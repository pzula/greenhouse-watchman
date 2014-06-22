$:.unshift File.join(__FILE__, "../config")

require 'clockwork'
require 'sinatra'
require 'mongoid'
require 'bundler/setup'
require 'sidekiq'
require 'redis'
require 'faraday'
require 'greenhouse_watchman_config'
require 'routes'

Dir.glob('./{models,helpers,controllers,workers}/*.rb').each { |file| require file }

class GreenhouseWatchman < Sinatra::Base
  set :app_file, __FILE__
  set :views, settings.root + '/views'
end

module Clockwork
  handler do |job|
    logger.info "Running #{job}"
  end

  every(2.minutes, SparkcoreWorker.new.perform)
end
