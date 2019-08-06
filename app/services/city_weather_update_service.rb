require 'nokogiri'
require 'open-uri'

class CityWeatherUpdateService

  def self.import(city, country)
    url = "https://www.timeanddate.com/weather/#{country}/#{city}/ext"
    @city = "#{city}".capitalize
    html_file = open(url).read
    doc = Nokogiri::HTML(html_file)
    doc.search('#qfacts').each do |element|
      @loc_name = doc.css('p')[2].text.strip
      @temp_now = doc.css('.h2').text.strip
      @wind = doc.css('p').children[5].text.strip
      @humidity = doc.css('p')[7].text.strip
      @icon = "https:" + doc.css('#cur-weather').attr('src').value
    end
    return {city: @city, location: @loc_name, temperature: @temp_now, humidity: @humidity, wind: @wind, icon:@icon}
  end
end
