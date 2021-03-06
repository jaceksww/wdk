xml.instruct!
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
  'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
) do
  @topics.each do |post|
   @date = Date.parse(post['datecreated']['date']).strftime("%F")
  
    xml.url do
      xml.loc "http://www.wedkarstwo.mobi/forums/viewtopic/"+post['topicid'].to_s
      xml.lastmod @date
      xml.changefreq("monthly")
    end
  end
end
#http://www.azgaard.com/2012/06/06/generating-a-sitemap-xml-file-on-heroku-with-ruby-on-rails/
