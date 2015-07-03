require 'digest/md5'
class UsersController < ApplicationController
  def isboot
  	
  	#https://www.google.com/recaptcha/admin#site/319320560?setup
       addArticleCaptcha= RestClient.post 'https://www.google.com/recaptcha/api/siteverify',
          {:secret => Rails.configuration.captcha_secret_addarticle, :response =>  params[:'g-recaptcha-response'] }
      captchaResp = JSON.parse(addArticleCaptcha)
      #render :text => captchaResp["success"]
      if captchaResp["success"].nil? || !captchaResp["success"]
      	flash[:error] = "Nie dodano artykułu. Źle zweryfikoany mechanizm antyspamowy"
      	session[:isboot] = 1
        redirect_to request.referer
      else
      	flash[:success] = "Prawidłowo zweryfikoany mechanizm antyspamowy. Teraz możesz więcej :)"
      	session[:isboot] = 0
        redirect_to request.referer
      end
  end
  def login
    if params.include?(:login)
        if params[:email]=='' || params[:password]==''
            flash[:error] = "Email i hasło obowiązkowe!"
            redirect_to users_login_path
        else
          @email = params[:email]
          @password = params[:password]
          @password_md5 = Digest::MD5.hexdigest(@password)
          
          require 'net/http'
          source = Rails.configuration.ws_url+'rest/users/login/'+@email+'/'+@password_md5
          resp = Net::HTTP.get_response(URI.parse(source))
          data = resp.body
          #result = JSON.parse(data)
          parsed_json = ActiveSupport::JSON.decode(data)
          
          #render :text => parsed_json.inspect
          if parsed_json == 0
            flash[:error] = "Nie ma takiego użytkownika w bazie"
            redirect_to users_login_path
          else
            session[:user] = parsed_json[0]
            #render :text => session[:user].inspect
            flash[:success] = "Zalogowano pomyślnie"
			redirect_to "/"
			
          end
          
        end
        
    else
      render(:layout=>"layouts/simple")
    end
  end
  
  def logout
    session.delete('user')
    flash[:success] = "Wylogowano pomyślnie"
    redirect_to "/"
  end

  def create_account
    if params.include?(:register)
      createAccount = RestClient.post Rails.configuration.ws_url+'rest/users/register', {:email => params[:email], :password =>  params[:password], :password2 =>  params[:password2],:displayname =>  params[:displayname]}
      parsed_json = ActiveSupport::JSON.decode(createAccount)
      #render :text => parsed_json.inspect
      if !parsed_json['error'].empty?
        ret = ''
        parsed_json['error'].each {|e| ret += e+"<br />"}
        flash[:error] = ret
        redirect_to users_create_account_path
      else
        #session[:user] = parsed_json[0]
        #render :text => session[:user].inspect
        flash[:success] = parsed_json['success'][0]
        redirect_to "/"
      end
    else
      render(:layout=>"layouts/simple")
    end     
  end

  def uzytkownicy
  end

  def profil
  	@userparams = {};
  	@user_displayname = params[:displayname]
          
    require 'net/http'
    source = Rails.configuration.ws_url+'rest/users/getuser/0/'+@user_displayname
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
         
    #render :text => parsed_json.inspect
    if parsed_json == 0
      flash[:error] = "Nie ma takiego użytkownika w bazie"
    else
      @userparams = parsed_json[0]
    end
  end
  def settings
  		if params.include?(:settings)
  	
		  #render :text => params.inspect
		  if !params[:settings_avatar].nil?
		    base64 = Base64.encode64(params[:settings_avatar].read)
		    imageName = params[:settings_avatar].original_filename
		  else
		    base64=''
		    imageName = ''
		  end
		  
		  
		  userID = params[:settings_userID]
		  displayname = params[:settings_displayname]
		  email = params[:settings_email]
		  current_password = params[:settings_current_password]
		  new_password = params[:settings_new_password]
		  new_password2 = params[:settings_new_password2]
		  #render :text => params
		    updateSettings= RestClient.post Rails.configuration.ws_url+'rest/users/settings/'+userID,
		      {:base64 => base64, :userID =>  userID, :imageName =>  imageName,
		        :displayname => displayname, :email => email, :current_password => current_password,
		         :new_password => new_password, :new_password2 => new_password2 }
		    parsed_json = ActiveSupport::JSON.decode(updateSettings)
		    #render :text => parsed_json.inspect
		    if !parsed_json['error'].empty?
				ret = ''
		      	parsed_json['error'].each {|e| ret += e+"<br />"}
		        flash[:error] =ret
		    else
		      flash[:success] ='Dane zostały zmienione'
		    end
  		end
  	
	  	@userparams = {};
	  	@user_userid = params[:userid]
		      
		require 'net/http'
		source = Rails.configuration.ws_url+'rest/users/getuser/'+@user_userid
		resp = Net::HTTP.get_response(URI.parse(source))
		data = resp.body
		#result = JSON.parse(data)
		parsed_json = ActiveSupport::JSON.decode(data)
		     
		#render :text => parsed_json.inspect
		if parsed_json[0].nil?
		  flash[:error] = "Nie ma takiego użytkownika w bazie"
		else
		  @userparams = parsed_json[0]
		end
	end
	
	def savefield
		userID = session[:user]['userid']
		  val = params[:val]
		  field = params[:field]
		 
		  #render :text => params
		    updateSettings= RestClient.post Rails.configuration.ws_url+'rest/users/updatefield/'+field+'/'+val.to_s+'/'+userID.to_s,
		      {}
		    parsed_json = ActiveSupport::JSON.decode(updateSettings)
		    #render :text => parsed_json.inspect
		    
		     flash[:success] ='Dane zostały zmienione'
		    redirect_to "/users/settings/"+userID.to_s
	end
end
