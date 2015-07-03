class LiveboxesController < ApplicationController
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
	
    source = Rails.configuration.ws_url+'rest/liveboxes/'+start.to_s+'/30'
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @liveboxes = parsed_json
    
    @breadcrumb_1['url'] = '/'
    @breadcrumb_1['name'] = 'Tablica'
	

    @page_title = 'Tablica'
    @page_sub_title = ', czyli cała aktywność uzytkowników...'
    
    @start = start
    @limit = limit
  end
end
