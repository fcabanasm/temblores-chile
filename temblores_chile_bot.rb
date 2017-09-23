require 'telegram/bot'
require 'httparty'
require 'pry'


token = ENV["TOKEN"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Bot Temblores Chile")
    when '/test'
      bot.api.send_message(chat_id: message.chat.id, text: "testing bot")

    else
      bot.api.send_message(chat_id: message.chat.id, text: "Bot Temblores Chile")
    end
  end
end
