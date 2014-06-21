class GreenhouseWatchman < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/data.json' do
    content_type :json
    all_data = Temperature.all + Humidity.all
    all_data.to_json
  end
end
