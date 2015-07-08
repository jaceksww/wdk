class WsController < ApplicationController
  
  before_filter :ws_load_defaults
  
  def ws_load_defaults
   	@breadcrumb_1['url'] = '/ws'
    @breadcrumb_1['name'] = 'Artykuły'
    @page_title = 'Artykuły'
  end

  def index
	require 'net/http'
    start = 0
    if params[:start]
        start = params[:start]
    end

	userid=0
    if params[:userid]
        userid = params[:userid]
    end
	limit= Rails.configuration.pagination_limit
 
    source = Rails.configuration.ws_url+'rest/ws/index/WWW/'+start.to_s+'/'+limit.to_s+'/'+userid.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
        #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @ws_arts = parsed_json
    @start = start
    @limit = limit
    
    @breadcrumb_1['name'] = 'Artykuły'
    @page_title = 'Artykuły'
    @page_sub_title = 'ryby, łowiska, opowieści, relacje wędkarskie'
  end
  
  def view
    require 'net/http'
    wwwid = 0
    if params[:wwwid]
        wwwid = params[:wwwid]
        wwwid = wwwid.gsub('w,', '')
       
    end
    #render :text => wwwid
    source = Rails.configuration.ws_url+'rest/ws/getwww/'+wwwid.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @view_ws_www = parsed_json
    
    @breadcrumb_1['name'] = 'Artykuły'
    @breadcrumb_2['url'] = 'w,'+wwwid
    
    if !@view_ws_www["0"]['excerpt'].nil? && @view_ws_www["0"]['excerpt'] != ""
    @page_title = 'Zdjęcia'
    @breadcrumb_1['name'] = 'Zdjęcia'
		@breadcrumb_2['name'] = @view_ws_www["0"]['excerpt'][0,30].html_safe+"..." if !@view_ws_www["0"]['excerpt'].nil?
		@page_sub_title = @view_ws_www['0']['excerpt'][0,30].html_safe+"..."
    else
    	@breadcrumb_2['name'] = @view_ws_www["0"]['wwwtitle']
		@page_sub_title = @view_ws_www['0']['wwwtitle']
    end
  end

  def galerie
    require 'net/http'
    start = 0
    if params[:start]
        start = params[:start]
    end

	userid=0
    if params[:userid]
        userid = params[:userid]
    end
	limit= Rails.configuration.pagination_limit
 
    source = Rails.configuration.ws_url+'rest/ws/index/GALERIA/'+start.to_s+'/'+limit.to_s+'/'+userid.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @ws_galleries = parsed_json
    @start = start
    @limit = limit
    
    @page_title = 'Zdjęcia'
    @page_sub_title = 'ryby, łowiska, rekordy, przynęty'
    @breadcrumb_1['name'] = 'Zdjęcia'
    @breadcrumb_1['url'] = 'ws/galerie'
  end
  
  def rejestr_polowow
    require 'net/http'
    start = 0
    if params[:start]
        start = params[:start]
    end

	userid=0
    if params[:userid]
        userid = params[:userid]
    end
	limit= Rails.configuration.pagination_limit
 	#render :text => Rails.configuration.ws_url+'rest/ws/index/REJESTR/'+start.to_s+'/'+limit.to_s+'/'+userid.to_s
    source = Rails.configuration.ws_url+'rest/ws/index/REJESTR/'+start.to_s+'/'+limit.to_s+'/'+userid.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @ws_registers = parsed_json
    @start = start
    @limit = limit
    
    @page_title = 'Rejestr połowów'
    @page_sub_title = 'ryby, okazy, rekordy, przynęty'
    @breadcrumb_1['name'] = 'Rejestr połowów'
    @breadcrumb_1['url'] = 'ws/rejestr-polowow'
  end

  def addimage
    @galleryid=0
    if !params[:galleryid].nil?
        @galleryid = params[:galleryid]
    end
    
    if params.include?(:addImage)
    
    
      #createAccount = RestClient.post 'http://www.ws.wedkarstwo.mobi/web/app_dev.php/rest/users/register', {:email => params[:email], :password =>  params[:password], :password2 =>  params[:password2]}
     # parsed_json = ActiveSupport::JSON.decode(createAccount)
      #render :text => params.inspect
      base64 = Base64.encode64(params[:image].read)
      userID = @USER['userid']
      imageName = params[:image].original_filename
      galleryCat = params[:addimage_gallery]
      subject = params[:subject]
      excerpt = params[:excerpt]
      subject2 = params[:subject2]
      custom1 = params[:custom1]
      custom2 = params[:custom2]
      custom3 = params[:custom3]
      dateCreated = params[:dateCreated]
      parentID = params[:parentID]
      #render :text => imageName
        addImage = RestClient.post Rails.configuration.ws_url+'rest/ws/addgalleryimage',
          {:base64 => base64, :userID =>  userID, :imageName =>  imageName,
            :galleryCat => galleryCat, :subject => subject, :excerpt => excerpt,
            :subject2 => subject2, :custom1 => custom1,:custom2 => custom2,:custom3 => custom3,
            :dateCreated => dateCreated, :parentID => parentID  }
        parsed_json = ActiveSupport::JSON.decode(addImage)
        #render :text => parsed_json.inspect
        if !parsed_json['error'].empty?
          ret = ''
          parsed_json['error'].each {|e| ret += e+"<br />"}
          flash[:error] = ret
          
          flash[:error] = "Nie ma takiego użytkownika w bazie"
          redirect_to ws_addimage_path
         else
         	flash[:success] = "Zdjęcie dodano pomyślnie"
            redirect_to '/'
        end
    end  
  end
  
  def addgallery
    if params.include?(:addGallery)
      
      userID = @USER['userid']
      galleryName = params[:galleryName]
     
        addGallery = RestClient.post Rails.configuration.ws_url+'rest/ws/addgallery',
          {:galleryName => galleryName, :userID =>  userID }
        parsed_json = ActiveSupport::JSON.decode(addGallery)
        #render :text => parsed_json
        if !parsed_json['error'].empty?
           @gallery = '{"error":1}';
            #respond_to do |format|
            #  format.json { render json: @gallery, status: 'error' }
            #end
            render(:json => @gallery, :content_type => 'application/json', :layout => false)
        else
          @gallery = '{"galleryname": "'+parsed_json['galleryname']+'", "galleryid":"'+parsed_json['galleryid'].to_s+'"}';
          #respond_to do |format|
          #  format.json { render json: @gallery, status: 'success' }
          #end
          render(:json => @gallery, :content_type => 'application/json', :layout => false)
        end
        
    end  
  end
  
  
  #registers
  
  def addrejestrfishery
    if params.include?(:addRejestrFishery)
      #createAccount = RestClient.post 'http://www.ws.wedkarstwo.mobi/web/app_dev.php/rest/users/register', {:email => params[:email], :password =>  params[:password], :password2 =>  params[:password2]}
     # parsed_json = ActiveSupport::JSON.decode(createAccount)
      #render :text => params.inspect
      
      if !params[:image].nil?
        base64 = Base64.encode64(params[:image].read)
        imageName = params[:image].original_filename
      else
        base64=''
        imageName = ''
      end
      
      
      userID = @USER['userid']
      description2 = params[:description2]
      excerpt = params[:excerpt]
      #render :text => imageName
        addFishery = RestClient.post Rails.configuration.ws_url+'rest/ws/addregisterfishery',
          {:base64 => base64, :userID =>  userID, :imageName =>  imageName,
           :description2 => description2, :excerpt => excerpt }
        parsed_json = ActiveSupport::JSON.decode(addFishery)
        #render :text => parsed_json.inspect
        if !parsed_json['error'].empty?
           @fishery = '{"error":1}';
            #respond_to do |format|
             # format.json { render json: @fishery, status: 'error' }
            #end
            render(:json => @fishery, :content_type => 'application/json', :layout => false)
        else
          @fishery = '{"name": "'+parsed_json['description2']+'", "id":"'+parsed_json['wwwid'].to_s+'"}';
          #respond_to do |format|
           # format.json { render json: @fishery, status: 'success' }
          #end
          render(:json => @fishery, :content_type => 'application/json', :layout => false)
        end
        
    end  
  end
  
  
  def addarticle
    if params[:id]
        source = Rails.configuration.ws_url+'rest/ws/getwww/'+params[:id].to_s
        resp = Net::HTTP.get_response(URI.parse(source))
        data = resp.body
        parsed_json = ActiveSupport::JSON.decode(data)
        @ws_www = parsed_json
        if @USER['userid'] != @ws_www["0"]["userid"] #+Time.now.getutc.to_i.to_s+"---"+Date.new(@ws_www["0"]["wwwdate"]).to_time.to_i.to_s 
        	render :text => 'Nie masz praw na edycję tego elementu ' 
    	end
    end
    
    if params.include?(:addArticle)
      
      if !params[:addarticle_mainimage].nil?
        base64 = Base64.encode64(params[:addarticle_mainimage].read)
        imageName = params[:addarticle_mainimage].original_filename
      else
        base64=''
        imageName = ''
      end
      
      wwwID=0
      if !params[:addarticle_wwwid].nil?
        wwwID = params[:addarticle_wwwid]
      end
      
      userID = @USER['userid']
      wwwTitle = params[:addarticle_wwwtitle]
      description = params[:addarticle_description]
      categoryID = params[:addarticle_wwwwcategory]
      galleryCat = params[:addarticle_gallery2]
      
        addArticle= RestClient.post Rails.configuration.ws_url+'rest/ws/addwww',
          {:base64 => base64, :userID =>  userID, :imageName =>  imageName,
            :galleryCat => galleryCat, :categoryID => categoryID, :description => description,
             :wwwTitle => wwwTitle, :wwwID => wwwID }
        parsed_json = ActiveSupport::JSON.decode(addArticle)
        #render :text => parsed_json.inspect
        if !parsed_json['error'].empty?
            @article = '{"error":1}';
            render(:json => @article, :content_type => 'application/json', :layout => false)
        else
          @article = '{}';
          wwwID = parsed_json['wwwID'].to_s
          if params[:addPhotosRedirect] == "1"
            redirect_to ws_addimage_path+"/"+galleryCat
          else
            if wwwID == 0
              redirect_to ws_addarticle_path
            else
              redirect_to ws_addarticle_path+'/'+wwwID
            end
          end
        end
    end  
  end
  
  def addcomment
    if params.include?(:comment)
      
      userID = params[:userID]
      comment = params[:comment]
      wwwID = params[:wwwID]
      fullName = params[:fullName]
      email = params[:email]
     
        addComment = RestClient.post Rails.configuration.ws_url+'rest/ws/addcomment',
          {:comment => comment, :userID =>  userID, :wwwID => wwwID, :fullName => fullName, :email => email }
        parsed_json = ActiveSupport::JSON.decode(addComment)
        #render :text => parsed_json
        if !parsed_json['error'].empty?
           flash[:error] = "Nie dodano komentarza.("+parsed_json['error'][0]['text']+")"
            redirect_to ws_path+'/w,'+wwwID
        else
          flash[:success] = "Dodano komentarz."
            redirect_to ws_path+'/w,'+wwwID
        end
        
    end  
  end
end
