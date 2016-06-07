require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require 'giphy'

get '/' do
  erb :form
end

post '/form' do
  rest_client.account.messages.create(
    from: ENV['TWILIO_NUMBER'],
    to: ENV['AMY'],
    media_url: Giphy.translate(params[:text])
  )
end

def rest_client
  account_sid = ENV['TWILIO_ACCOUNT_SID']
  auth_token = ENV['TWILIO_AUTH_TOKEN']
 
  client = Twilio::REST::Client.new account_sid, auth_token
end