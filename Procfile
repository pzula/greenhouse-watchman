web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -r application.rb
clock: bundle exec clockwork application.rb
