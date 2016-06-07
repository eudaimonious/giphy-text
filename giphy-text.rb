require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require 'json'
require 'rest-client'


get '/' do
  erb :form
end

post '/form' do
  twilio_rest_client.account.messages.create(
    from: ENV['TWILIO_NUMBER'],
    to: ENV['AMY'],
    body: "Powered by Giphy"
    media_url: gif_url(params[:text])
  )
end

private

def twilio_rest_client
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  client = Twilio::REST::Client.new account_sid, auth_token
end

def gif_url(text)
  api_result = JSON.parse(request_gif)
  api_result[:data][:original][:url]
end

def request_gif
  public_beta_giphy_api_key = "dc6zaTOxFJmzC"
  translate_endpoint = "http://api.giphy.com/v1/gifs/translate"
  RestClient.get("#{translate_endpoint}?s=#{params[:text]}&api_key=#{public_beta_giphy_api_key}")
end