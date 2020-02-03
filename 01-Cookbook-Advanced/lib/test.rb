require_relative 'cookbook'
require_relative 'recipe'
filepath = 'lib/recipes.csv'
test_cookbook = Cookbook.new(filepath)
recipe_pizza = Recipe.new("Pizza", "Very delicious pizza")
test_cookbook.all # => []
test_cookbook.add_recipe(recipe_pizza)
p test_cookbook.all
