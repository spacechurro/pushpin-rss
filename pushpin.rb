require 'nokogiri'
require 'open-uri'
require 'rss'
require 'sinatra'


get '/t\::tag' do
  content_type 'text/xml'
  doc = Nokogiri::HTML(open("https://pinboard.in/popular/t:#{params[:tag]}/"))

  rss = RSS::Maker.make("atom") do |maker|
    maker.channel.author = "pushpin"
    maker.channel.updated = Time.now.to_s
    maker.channel.title = "pushpin"
    maker.channel.id = "pushpin"

    doc.css('div.bookmark').each do |bookmark|
      maker.items.new_item do |item|
        item.link = bookmark.at_css('.bookmark_title')['href']
        item.title = bookmark.at_css('.bookmark_title').content
        item.updated = Time.now.to_s
      end
    end
  end
  rss.to_s
end

