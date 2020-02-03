require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

file = 'fraise.html' # or 'strawberry.html'
doc = Nokogiri::HTML(File.open(file), nil, 'utf-8')
first_five_recipes = []

doc.search('.recipe-card').first(5).each do |element|
  first_five_recipes << {
    title: element.at_css('.recipe-card__title').text.strip,
    description: element.at_css('.recipe-card__description').text.strip,
    prep_time: element.at_css('.recipe-card__duration__value').text.strip
  }
end

first_five_recipes.map! do |recipe|
  Recipe.new(recipe[:title], recipe[:description], recipe[:prep_time])
end

p first_five_recipes

# display_recipes = first_five_recipes.each_with_index do |recipe, index|
#   puts "#{index + 1} - #{recipe.name} (#{recipe.prep_time}) : #{recipe.description}"
# end
# # p first_five_recipes.size
# # p first_five_recipes[2]
# p display_recipes
