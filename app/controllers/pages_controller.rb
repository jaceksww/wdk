class PagesController < ApplicationController
  def index
    type = params[:id] if params[:id]
    require 'net/http'
    source = Rails.configuration.ws_url+'rest/pages/'+type
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @pages = parsed_json
  end

  def view
    pageid = params[:id]
    
    require 'net/http'
    source = Rails.configuration.ws_url+'rest/pages/'+pageid
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @pages = parsed_json
    
  end
  
  def ryby
    require 'net/http'
    source = Rails.configuration.ws_url+'rest/pages/6'
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @pages = parsed_json
    
    @page_title = 'Ryby'
    @page_sub_title = 'ryby, opis, przynęty, okres ochronny, wymiar ochronny'
    @breadcrumb_1['name'] = 'Ryby'
    @breadcrumb_1['url'] = 'ryby'
    
    render "index"
  end
  def ryba
    pageid = params[:id]
    if params[:more]
        pageid += '-_-'+params[:more]
    end
    
    
    #render :text => pageid
    require 'net/http'
    source = Rails.configuration.ws_url+'rest/pages/view/ryby-_-'+pageid
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    #result = JSON.parse(data)
    parsed_json = ActiveSupport::JSON.decode(data)
    
    @pages = parsed_json
    
    @page_title = @pages[0]['pagename']
    if params[:more]
    @page_sub_title = ''
    else
    @page_sub_title = 'Na co bierze '+@pages[0]['pagename']+ ', kiedy bierze '+@pages[0]['pagename']+ ', jak złowić '+@pages[0]['pagename']+ ', przynęty, zanęty'
    end
    @breadcrumb_1['name'] = 'Ryby'
    @breadcrumb_1['url'] = '/ryby'
    @breadcrumb_2['name'] = @pages[0]['pagename']
    @breadcrumb_2['url'] = '/'+@pages[0]['uri']
    
    
  end
end
