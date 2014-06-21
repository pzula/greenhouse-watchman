require './config/greenhouse_watchman_config'

class Temperature
  include Mongoid::Document

  field :date, type: Time
  field :reading, type: Float
end


