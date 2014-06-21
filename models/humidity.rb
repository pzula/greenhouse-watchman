require './config/greenhouse_watchman_config'

class Humidity
  include Mongoid::Document

  field :date, type: Time
  field :reading, type: Float
end


