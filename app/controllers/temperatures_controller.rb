class TemperaturesController < ApplicationController

  def index

    if params[:city] == ""
      @city = "Chicago"
    else
      @city = params[:city]
    end

    if params[:state] == ""
      @state = "IL"
    else
      @state = params[:state]
    end

    temps = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{@city}%2C%20#{@state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
   
    @temperature = temps["query"]["results"]["channel"]["item"]["condition"]["temp"]
    @forecasts = temps["query"]["results"]["channel"]["item"]["forecast"]
  end
end


