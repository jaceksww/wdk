class MessagesController < ApplicationController
  before_filter :forums_load_defaults
  
  def forums_load_defaults
   	@breadcrumb_1['url'] = '/messages'
    @breadcrumb_1['name'] = 'Wiadomości'
    @page_title = 'Wiadomości'
  end
  def latest
  end
  
  def inbox
  	#checkauth("3")
  	require 'net/http'
    start = 0
    if params[:start]
        start = params[:start]
    end

	userid=session[:user]['userid']
	limit= Rails.configuration.pagination_limit
 
    source = Rails.configuration.ws_url+'rest/messages/inbox/'+userid.to_s+'/'+start.to_s+'/'+limit.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    parsed_json = ActiveSupport::JSON.decode(data)
    #render :text => parsed_json.inspect
    @inbox_messages = parsed_json
    
    @breadcrumb_2['url'] = '/messages/inbox'
    @breadcrumb_2['name'] = 'Odebrane'
    
    @page_sub_title = 'Wiadomości - skrzynka odbiorcza'
  end

  def outbox
  	#checkauth("3")
  	require 'net/http'
    start = 0
    if params[:start]
        start = params[:start]
    end

	userid=session[:user]['userid']
	limit= Rails.configuration.pagination_limit
 
    source = Rails.configuration.ws_url+'rest/messages/outbox/'+userid.to_s+'/'+start.to_s+'/'+limit.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    parsed_json = ActiveSupport::JSON.decode(data)
    #render :text => parsed_json.inspect
    @outbox_messages = parsed_json
    
    @breadcrumb_2['url'] = '/messages/inbox'
    @breadcrumb_2['name'] = 'Odebrane'
    
    @page_sub_title = 'Wiadomości - skrzynka odbiorcza'
  end

  def deleted
  end

  def create
  @selectuserid = 0
    if params[:touserid]
        @selectuserid = params[:touserid]
    end
    
  userID = @USER['userid']
  	if params.include?(:createMessage)
  		@subject= params[:message][0,30]+"...";
  		if params.include?(:subject) && params[:subject] != ''
  			@subject = params[:subject]
  		end
    	#render :text => params
		createMessage = RestClient.post Rails.configuration.ws_url+'rest/messages/add',
		 {:userID =>  userID, :touserID =>  params[:to],
		  :message => params[:message],:subject => @subject  }
		parsed_json = ActiveSupport::JSON.decode(createMessage)
		#topicID = parsed_json['topicid'].to_s
		flash[:success] = "Wiadomość wysłana pomyślnie"
            redirect_to '/messages/outbox'
    end
    users = RestClient.post Rails.configuration.ws_url+'rest/users/getusers',
		 {:query =>  ''  }
		parsed_json = ActiveSupport::JSON.decode(users)
	@users = parsed_json
    @breadcrumb_2['url'] = '/messages/create'
    @breadcrumb_2['name'] = 'Nowa wiadomość'
    
    @page_sub_title = 'Wiadomości - nowa wiadomość'
  end

  def delete
  end

  def view
  	require 'net/http'
    
	userID = @USER['userid']
	
    source = Rails.configuration.ws_url+'rest/messages/view/'+params[:messageid].to_s+'/1/'+userID.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    parsed_json = ActiveSupport::JSON.decode(data)
    #render :text => parsed_json.inspect
    if userID != parsed_json['userid'] && userID != parsed_json['touserid']
    	render :text => "???"
    end 
    
    @message = parsed_json
    @breadcrumb_2['url'] = '/messages/view/'+params[:messageid]
    @breadcrumb_2['name'] = 'Wiadomość'
    
    @page_sub_title = 'Wiadomości - czytaj wiadomość'
  end

  def delete
  	require 'net/http'
    
	userID = session[:user]['userid']
	
	if userID.to_s != params[:userid].to_s
		render :text => "???"+userID.to_s+"--"+params[:userid].to_s
    else
		#render :text => Rails.configuration.ws_url+'rest/messages/delete/'+params[:messageid].to_s+'/'+params[:userid].to_s;
        source = Rails.configuration.ws_url+'rest/messages/delete/'+params[:messageid].to_s+'/'+params[:userid].to_s
		resp = Net::HTTP.get_response(URI.parse(source))
		data = resp.body
		parsed_json = ActiveSupport::JSON.decode(data)
		flash[:success] = "Element został usunięty"
		redirect_to "/messages/inbox"
	end
   
  end
end
