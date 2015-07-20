require 'httparty'
require 'json'

class BusAPI
  include HTTParty
  Token = File.read "./wmata_token.txt"
  # base_url 'https://api.wmata.com/NextBusService.svc/json/jPredictions'
  
  def closest_stops lat, long
    # Gets every stop ID within x meters radius of a given latitude and longitude
    # Performance issues need to be addressed
    search = HTTParty.get("https://api.wmata.com/Bus.svc/json/jStops?Lat=#{lat}&Lon=#{long}&Radius=50", query: {api_key: "#{Token}"})
    stop_ids = search["Stops"].map { |l| l["StopID"] }
    
    predictions = []
    all_predictions = stop_ids.map { |g| HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions?StopId=#{g}", query: {api_key: "#{Token}"}) }
    # need to rewrite this to show just the first 15 buses by minutes
    next_fifteen = all_predictions.select { |s| s["Prediction"]["Minutes"] > 15 }
    end
    # next_fifteen.each do |d|
    #   info = {
    #     address: d.first["StopName"],
    #     bus_num: d.first["StopName"].first["Predictions"].first["RouteID"],
    #     direction: d.first["StopName"].first["Predictions"].first["DirectionText"],
    #     minutes: d.first["StopName"].first["Predictions"].first["Minutes"]
    #   }
    # end
    # return predictions.to_json
  end