require_relative 'cookbook'    # You need to create this file!
require_relative 'controller'  # You need to create this file!
require_relative 'router'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

csv_file   = File.join(__dir__, 'recipes.csv')
cookbook   = Cookbook.new(csv_file)


get '/' do
  recipes = cookbook.all
  erb :index
end

get '/about' do
  erb :about
end





# controller = Controller.new(cookbook)

# router = Router.new(controller)

# # Start the app
# router.run
