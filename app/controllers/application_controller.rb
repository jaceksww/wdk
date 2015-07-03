class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :ws_load_subjects
  
  def ws_load_subjects
	@breadcrumb_1 = {}
	@breadcrumb_2 = {}
	@breadcrumb_3 = {}

    require 'net/http'
    #render :text => wwwid
=begin
    source = 'http://ws.wedkarstwo.mobi/web/app_dev.php/rest/ws/subjects'
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    parsed_json = ActiveSupport::JSON.decode(data)
    @subjects = parsed_json
    
    source_sub2 = 'http://ws.wedkarstwo.mobi/web/app_dev.php/rest/ws/subjects2'
    resp_sub2 = Net::HTTP.get_response(URI.parse(source_sub2))
    data_sub2 = resp_sub2.body
    parsed_json_sub2 = ActiveSupport::JSON.decode(data_sub2)
    @subjects2 = parsed_json_sub2
    
    
    source_rp = 'http://ws.wedkarstwo.mobi/web/app_dev.php/rest/ws/index/REJESTR_LOWISKO/0/100/2'
    resp_rp = Net::HTTP.get_response(URI.parse(source_rp))
    data_rp = resp_rp.body
    parsed_json_rp = ActiveSupport::JSON.decode(data_rp)
    @rejestr_lowisko = parsed_json_rp
    
    source_ug = 'http://ws.wedkarstwo.mobi/web/app_dev.php/rest/ws/usergalleries/2'
    resp_ug = Net::HTTP.get_response(URI.parse(source_ug))
    data_ug = resp_ug.body
    parsed_json_ug = ActiveSupport::JSON.decode(data_ug)
    @user_galleries = parsed_json_ug
    
    source_c = 'http://ws.wedkarstwo.mobi/web/app_dev.php/rest/ws/categories'
    resp_c = Net::HTTP.get_response(URI.parse(source_c))
    data_c = resp_c.body
    parsed_json_c = ActiveSupport::JSON.decode(data_c)
    @ws_categories = parsed_json_c
=end
    @USER = {}
	if session[:user]
		@USER =session[:user]
	else
		@USER['displayname'] = 'Gość'    
		@USER['userid'] = 303
 	end
    source = Rails.configuration.ws_url+'rest/default/dictionaries/'+@USER['userid'].to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    parsed_json = ActiveSupport::JSON.decode(data)
    #render :text => parsed_json['messages'].inspect
    @global_infos = parsed_json['infos']
    @global_messages = parsed_json['messages']
    @subjects = parsed_json['subjects']
    @subjects2 = parsed_json['subjects2']
    @rejestr_lowisko = parsed_json['registerfisheries']
    @user_galleries = parsed_json['usergalleries']
    @ws_categories = parsed_json['categories']
    @forum_categories = parsed_json['forum_categories']
   
  end
  
  helper_method :checkauth

  def checkauth(params)
    if(!session[:user]['userid'] || (params && session[:user]['userid'] != params['userid']))
    	flash[:error] = 'Nie masz dostępu do tych informacji'
    	redirect_to "/"
    end 
  end
  
end
