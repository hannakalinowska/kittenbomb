require 'sinatra/base'

class Kittenbomb < Sinatra::Base
  get '/image' do
    erb :image
  end
end
