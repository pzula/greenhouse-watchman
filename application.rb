$:.unshift File.join(__FILE__, "../config")

require 'sinatra'
require 'mongoid'
require 'bundler/setup'
require 'faraday'
require 'greenhouse_watchman_config'
require 'routes'
require 'sidekiq'
require 'redis'
require 'sidekiq/api'
require 'clockwork'

Dir.glob('./{models,helpers,controllers,workers}/*.rb').each { |file| require file }

class GreenhouseWatchman < Sinatra::Base
  set :app_file, __FILE__
  set :views, settings.root + '/views'
end

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(10.minutes, 'sparkcoreworker.job') { SparkcoreWorker.perform_async }
end
