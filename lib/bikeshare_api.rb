require 'httparty'
require 'haversine'

class BikeAPI
  include HTTParty

  def distance lat1, long1
    response = HTTParty.get("https://www.capitalbikeshare.com/data/stations/bikeStations.xml")
    docking_stations = response["stations"]["station"]
    
    docking_stations.each do |s|
      distance_to_here = Haversine.distance(lat1.to_f, long1.to_f, s["lat"].to_f, s["long"].to_f).to_mi
      s["distance"] = distance_to_here
    #   latlongs.push [s["lat"].to_f, s["long"].to_f]
    end
    top_5 = docking_stations.min_by(5) { |s| s["distance"] } 
    details top_5
  end

  def details top_5
    results = []
    top_5.each do |d|
      info = {
        location: d["name"],
        bikes_avail: d["nbBikes"],
        docks_avail: d["nbEmptyDocks"]
      }
      results.push info
    end
   return results.to_json
  end
end