# We need a few superpowers for this example. Obviously,
require 'rack'
require 'pry'

# Ignore this line.
Signal.trap('INT') {Rack::Handler::WEBrick.shutdown}

# Now let's grab the superpower twitter.

# https://github.com/sferik/twitter

# First, install the twitter gem from your terminal.

# gem install twitter

# Great, let's get it in this script.

require 'twitter'

Twitter.configure do |config|
  # I got this information from creating a new twitter application
  # under my developer account. 
  # https://dev.twitter.com/apps
  config.consumer_key = "9vahfyWzOnjJxj83SJxROQ"
  config.consumer_secret = "aYCt7k10fYf4svlSNz9oP7GbFi1QYPnUdvpOZpjgwYM"
  config.oauth_token = "2085091-QdSttXlwq50BXqOUrNmd2zIPdQyxP873TzzsKhW8k"
  config.oauth_token_secret = "MxwEh2JRvmHBYcMfsFv3o0MYhMx2yM77tVABftVboAE"
end

# What do you think is going on up there? Well the twitter gem gives us a class,
# Twitter. We're configure the class with our credentials. Now that class basically
# represents twitter.

# Let's make our rack app.

class App
  def call(env)
    html = File.read('tweets.erb')
    template = ERB.new(html)

    twitter_search_results = Twitter.search("flatironschool")
    
    [200, {'Content-Type' => 'text/html'}, [template.result(binding)]]
  end
end

# Okay and now our Rack Handler to actually load the application
# on port 3002 of our computer.

Rack::Handler::WEBrick.run(App.new, {:Port => 3002})

# You should see the Rack output letting you know you have a server
# running, this time on port 3002.

# Open your browser again to http://localhost:3002
#
# Now look and see what people are saying about the Flatiron School on Twitter!
#
# What else can you build into this? Check out the Twitter gem
# here https://github.com/sferik/twitter
#
# See what else you can do with rack!
