## Greenhouse Watchman

Using the SparkCore (a wifi-enabled Arduino for $30) and a DHT-22 Temperature and Humidity Sensor ($6), I am able to get readings from my greenhouse on temperture and humidity. Currently I'm just pinging the API for the information to show on a plain ol' HTML page, but plans are for:

- ~~Storing the data~~
- Charting the data
- Enabling others to reuse this project

When it's powered on, you can currently see the temperature in my greenhouse here <http://greenhouse-watchman.herokuapp.com/>

**Update 2014-06-21**

- Added MongoDB for persistence
- Added Sidekiq for background jobs
- Added Clockwork for scheduling the background jobs


### How to run

- `git clone` this repository
- Run `bundle install` to install the required gems
- Start the server with `rackup`
- Start Sidekiq in another terminal window with `bundle exec -r ./application.rb`
- Start Clockwork in another terminal window with `clockwork application.rb`
- There is a rake task to monitor the Sidekiq jobs, you can start it in another terminal window with `rake monitor`
