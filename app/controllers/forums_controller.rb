class ForumsController < ApplicationController
  before_filter :forums_load_defaults
  
  def forums_load_defaults
   	@breadcrumb_1['url'] = '/forums/index'
    @breadcrumb_1['name'] = 'Forum'
    @page_title = 'Forum'
  end

  def index
    
    require 'net/http'
    id =0
    if params[:id]
        id = params[:id]
    end
    
     source = Rails.configuration.ws_url+'rest/forums/index/'+id.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @forums = parsed_json
	@page_title = 'Forum'
	@page_sub_title = 'forum wędkarskie, łowiska, forum ryby sprzęt przynęty'
  end

  def viewforum
    require 'net/http'
    id =0
    if params[:id]
        id = params[:id]
    end
    source = Rails.configuration.ws_url+'rest/forums/topics/'+id
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @forums_topics = parsed_json

    @breadcrumb_2['url'] = '/forums/viewforum/'+id
    @breadcrumb_2['name'] = @forums_topics[0]['forumname']

	@page_sub_title = @forums_topics[0]['forumname']
  end

  def viewtopic
    require 'net/http'
    id =0
    if params[:id]
        id = params[:id]
    end
    start = 0
    if params[:start]
        start = params[:start]
    end
    limit= Rails.configuration.pagination_limit
    
    source = Rails.configuration.ws_url+'rest/forums/posts/'+id.to_s+'/'+start.to_s+'/'+limit.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @forums_posts = parsed_json
	@start = start
    @limit = limit
    
	@breadcrumb_2['url'] = '/forums/viewforum/'+@forums_posts[0]['forumid'].to_s
    @breadcrumb_2['name'] = @forums_posts[0]['forumname'].to_s
	@breadcrumb_3['url'] = '/forums/viewtopic/'+id.to_s
    @breadcrumb_3['name'] = @forums_posts[0]['topictitle'].to_s

    @page_sub_title = @forums_posts[0]['topictitle']
  end

  def addtopic
  end

  def addreply
    #render :text => params
    
    userID = @USER['userid']
    topicID = 0
    
      
    if params.include?(:addTopic) && session[:isboot] == 0
    	topicTitle = params[:topicTitle]
        forumID = params[:forumID][params[:catID]]
		#render :text => forumID
		addTopic = RestClient.post Rails.configuration.ws_url+'rest/forums/addtopic',
		 {:userID =>  userID, :topicTitle =>  topicTitle,
		  :forumID => forumID  }
		parsed_json = ActiveSupport::JSON.decode(addTopic)
		topicID = parsed_json['topicid'].to_s
    end
        
    if params.include?(:addPost) && session[:isboot] == 0
      base64 = ''
      imageName = ''
      if params.include?(:image)
		  base64 = Base64.encode64(params[:image].read)
		  imageName = params[:image].original_filename
      end

      body = params[:body]
	  if topicID == 0
      	topicID = params[:topicID]
      end
        addArticle = RestClient.post Rails.configuration.ws_url+'rest/forums/addpost',
          {:base64 => base64, :userID =>  userID, :imageName =>  imageName,
            :body => body, :topicID => topicID  }
        parsed_json = ActiveSupport::JSON.decode(addArticle)
        postID = parsed_json['postid'].to_s
        
       
        #render :text => parsed_json.inspect
        #render :text => postID
        
        if !parsed_json['error'].empty?
          ret = ''
          parsed_json['error'].each {|e| ret += e['text']+"<br />"}
          flash[:error] = ret
          
          redirect_to forums_addreply_path
         else
         	flash[:success] = "Post dodano pomyślnie"
            redirect_to request.referer
        end
    end  
  end
  
  def deletepost
  	require 'net/http'
    
	userID = session[:user]['userid']
	
	if userID.to_s != params[:userid].to_s
		render :text => "???"
    else
		#render :text => Rails.configuration.ws_url+'rest/messages/delete/'+params[:messageid].to_s+'/'+params[:userid].to_s;
        source = Rails.configuration.ws_url+'rest/forums/deletepost/'+params[:postid].to_s
		resp = Net::HTTP.get_response(URI.parse(source))
		data = resp.body
		parsed_json = ActiveSupport::JSON.decode(data)
		flash[:success] = "Element został usunięty"
		redirect_to "/forums/viewtopic/"+params[:topicid].to_s
	end
   
  end

  def subscribe
  end
  
end
