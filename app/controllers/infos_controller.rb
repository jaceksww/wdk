class InfosController < ApplicationController
	before_filter :forums_load_defaults
  
  def forums_load_defaults
   	@breadcrumb_1['url'] = '/infos'
    @breadcrumb_1['name'] = 'Informowanie'
    @page_title = 'Informowanie'
  end
  def index
  	require 'net/http'
    start = 0
    if params[:start]
        start = params[:start]
    end

	userid=session[:user]['userid']
	limit= Rails.configuration.pagination_limit
 
    source = Rails.configuration.ws_url+'rest/infos/'+userid.to_s+'/'+start.to_s+'/'+limit.to_s
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    parsed_json = ActiveSupport::JSON.decode(data)
    #render :text => parsed_json.inspect
    @infos = parsed_json
    
    @page_sub_title = 'Cała aktywność na portalu związana z Tobą'
  end

  def latest
  end
end
