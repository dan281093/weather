class PagesController < ApplicationController

  def home
    @telaviv = CityWeatherUpdateService.import("tel-aviv", "israel")
    @paris = CityWeatherUpdateService.import("paris", "france")

    if params[:address]

      if params[:address].match?(/^(.+),(.+),(.+)/)
        match_data = params[:address].match(/^(.+),(.+),(.+)/)
        city = match_data[1].downcase.strip.gsub(" ", "-")
        country = match_data[3].downcase.strip
      else
        match_data= params[:address].match(/^(.+),(.+)/)
        country = match_data[2].downcase.strip
      end

      city = match_data[1].downcase.strip.gsub(" ", "-")
      country = "usa" if country == "united states of america"
      @city_weather = CityWeatherUpdateService.import(city, country)
    end
  end
end
