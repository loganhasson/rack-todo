require 'rack'
require 'twitter'
require 'erb'

Signal.trap('INT') {Rack::Handler::WEBrick.shutdown}

Twitter.configure do |config|
  config.consumer_key = "9vahfyWzOnjJxj83SJxROQ"
  config.consumer_secret = "aYCt7k10fYf4svlSNz9oP7GbFi1QYPnUdvpOZpjgwYM"
  config.oauth_token = "2085091-QdSttXlwq50BXqOUrNmd2zIPdQyxP873TzzsKhW8k"
  config.oauth_token_secret = "MxwEh2JRvmHBYcMfsFv3o0MYhMx2yM77tVABftVboAE"
end

class TwitterApp

  def generate_html
    show = ERB.new(File.open("messing.around/templates/tweet_show.erb").read)
    twitter_search_results = Twitter.search("flatironschool")
    twitter_search_results.statuses.first do |tweet|
      show.result(binding)
    end
  end

  def call(env)
    [200, {"Content-Type" => "text/html" }, [generate_html]]
  end

end

twitter_app = TwitterApp.new


Rack::Handler::WEBrick.run(twitter_app, {:Port => 3000})