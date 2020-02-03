require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative '01-Cookbook-Advanced/lib/cookbook'    # You need to create this file!
require_relative '01-Cookbook-Advanced/lib/controller'  # You need to create this file!
require_relative 'router'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end


