require 'dotenv'
Dotenv.load

require './greenhouse'
run Sinatra::Application
