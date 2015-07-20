require 'httparty'
require 'json'

class RailAPI
  include HTTParty

  Token = File.read "./wmata_token.txt"

  def closest_station lat1, long1
    response = HTTParty.get("https://api.wmata.com/Rail.svc/json/jStations", query: {api_key: "#{Token}"})
    metro_station = response["Stations"]
    metro_station.each do |m|
      distance_to_here = Haversine.distance(lat1.to_f, long1.to_f, m["Lat"], m["Lon"]).to_mi
      m["distance"] = distance_to_here
    end
    asc_stations = metro_station.sort_by { |h| h["distance"] }
    chosen_station = asc_stations.first
    next_trains chosen_station
  end

  def next_trains chosen_station
    # Gets data from Station Prediction API using "Code" from the Station Info API
    code = chosen_station["Code"]
    predictions = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{code}", query: {api_key: "#{Token}"})
    trains = predictions["Trains"] # Isolates the API into an array of train hashes

    # For each of the trains listed in the Predictions API, FEE only needs the following information
    results = []
    trains.each do |d|
      info = {
        arriving_at: d["LocationName"],
        line: d["Line"],
        destination: d["DestinationName"],
        minutes: d["Min"].to_i
      }
      results.push info
    end
    return results.to_json
  end
end