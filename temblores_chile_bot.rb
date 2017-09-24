require 'telegram/bot'
require 'httparty'
require 'pry'
require 'dotenv/load'
require 'twitter'
require 'json'
require 'mechanize'

token = ENV["BOT_API_TOKEN"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
  
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Bot Temblores Chile se encuentra en desarrollo, contactar a @fcabanasm para más información")
      
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: "Bot Temblores Chile se encuentra en desarrollo, contactar a @fcabanasm para más información")
  
    when '/twitter'
      twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV["CONSUMER_KEY"]
        config.consumer_secret = ENV["CONSUMER_SECRET"]
        config.access_token = ENV["ACCESS_TOKEN"]
        config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
      end
      search_term = URI::encode('#temblor ')
      tweets = twitter.search("#{search_term}", result_type: "recent").take(5)
      if tweets
        tweets = tweets.map do |tweet|
          { name: tweet.user.name, body: tweet.text }
        end
        bot.api.send_message(chat_id: message.chat.id, text: "Tweets: #{tweets}")
      end
      
    when '/sismologia'
      mechanize = Mechanize.new
      page = mechanize.get('http://www.sismologia.cl/links/ultimos_sismos.html')
      bot.api.send_message(chat_id: message.chat.id, text: page.at('table').text.strip)
      
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Bot Temblores Chile se encuentra en desarrollo, contactar a @fcabanasm para más información")
    end
    
  end
end
