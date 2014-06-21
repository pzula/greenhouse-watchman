$:.unshift File.join(__FILE__, "../config")

require 'sinatra'
require 'mongoid'
require 'bundler/setup'
require 'greenhouse_watchman_config'
require 'routes'

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

class GreenhouseWatchman < Sinatra::Base
  set :app_file, __FILE__
  set :views, settings.root + '/views'
end
