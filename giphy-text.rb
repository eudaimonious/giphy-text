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
    from: ENV['TWILIO_NUMBER'], # did the applicant expose this and other info in code or use environment vars?
    to: ENV['AMY'],
    body: "Powered by Giphy", # did the applicant notice that GiphyAPI requested this be included with all gifs?
    media_url: gif_url
  )
end

private

def twilio_rest_client
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
  client = Twilio::REST::Client.new account_sid, auth_token
end

def gif_url
  api_result = JSON.parse(request_gif)
  api_result["data"]["images"]["original"]["url"]
end

def request_gif
  public_beta_giphy_api_key = "dc6zaTOxFJmzC"
  translate_endpoint = "http://api.giphy.com/v1/gifs/translate"
  search_text = URI.escape(params[:text]) # did the applicant encode the text for urls?
  RestClient.get("#{translate_endpoint}?s=#{search_text}&api_key=#{public_beta_giphy_api_key}")
end