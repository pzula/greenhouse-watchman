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
- Make sure you have MongoDB and Redis on your machine: `brew install mongodb && brew install redis`
- Run `bundle install` to install the required gems
- Start the server with `rackup` or `bundle exec unicorn`
- Start Sidekiq in another terminal window with `bundle exec sidekiq -r ./application.rb`
- Start Clockwork in another terminal window with `clockwork application.rb`
- There is a rake task to monitor the Sidekiq jobs, you can start it in another terminal window with `rake monitor`

### How to deploy to Heroku

- `git clone` this repository
- Create an account on <http://heroku.com>
- Install the Heroku CLI (<https://devcenter.heroku.com/articles/heroku-command>)
- Create a new app from the same folder as this app using `heroku apps:create your-app-name`
- Run `git push heroku master` to deploy the app
- Install Redis on Heroku using: `heroku addons:add redistogo`
- Install MongoDB on Heroku using: `heroku addons:add mongohq`
- Make sure the `Procfile` has the correct settings if you've made any modifications to the app
- Set your environment variables on Heroku:
  - `heroku config:set REDIS_PROVIDER=REDISTOGO_URL`
  - `heroku config:set ACCESS_TOKEN=yourSparkAccessToken`
  - `heroku config:set DEVICE_ID=yourSparkDeviceID`
- Make sure any changes to the production database setup that you need are made in `config/mongoid.yml`
- Scale up for redis and clockwork using: `heroku scale web=1 worker=1 clock=1`
- If you've done everything above, and scaled with the above command, the **estimated monthly cost with Heroku is $70.50**. That's a little insane for this small project, so Heroku may not be a viable option.
