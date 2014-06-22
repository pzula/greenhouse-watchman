class SparkcoreWorker
  include Sidekiq::Worker

  $redis = Redis.new

  def perform(msg ="You forgot a message")
    logger.info "Kicking off the SparkCore Worker!!"

    $redis.lpush("get_sparkcore_data", store_data)

    logger.info "SparkCore Worker is done"
  end

  private

  def spark_vars
    ["temperature", "humidity"]
  end

  def spark_var_to_model(var)
    Module.const_get(var.capitalize)
  end

  def store_data
    spark_vars.each do |spark_var|
      request_url = "https://api.spark.io/v1/devices/" + ENV['DEVICE_ID'] + "/" + spark_var  + "?access_token=" + ENV['ACCESS_TOKEN']
      response = Faraday.get(request_url)
      parsed_response = JSON.parse(response.body)

      spark_var_to_model(spark_var).create(date: parsed_response['coreInfo']['last_heard'], reading: parsed_response['result'])
    end
  end

end

