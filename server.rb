require 'sinatra/base'
require 'haversine'
require 'rack/cors'
require './db/setup'
require './lib/all'


class RubyLineApp < Sinatra::Base
  enable :logging
  enable :method_override
  enable :sessions

  set :session_secret, (ENV["SESSION_SECRET"] || "development")

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: :get
    end
  end

  before do
      headers["Content-Type"] = "application/json"
    end

  after do
    ActiveRecord::Base.connection.close
  end

  get "/rail/:lat/:long" do
    r = RailAPI.new
    r.closest_station params[:lat], params[:long]
  end

  get "/bus/:lat/:long" do
    m = BusAPI.new
    m.closest_stops params[:lat], params[:long]
  end

  get "/bike/:lat/:long" do
    b = BikeAPI.new
    b.distance params[:lat], params[:long]
  end
end

RubyLineApp.run! if $PROGRAM_NAME == __FILE__