# Cookbook must act as our repository
require 'csv'
require 'nokogiri'
require 'open-uri'
require_relative 'recipe'
class Cookbook
  def initialize(csv_file_path)
    # Find out which instance variable to add here
    @csv_file_path = csv_file_path
    @recipes = []
    import_csv_file(@csv_file_path)
  end

  def all
    # List all my recipes
    @recipes
  end

  def add_recipe(recipe)
    # Allows to add a recipe to our cookbook
    @recipes << recipe
    # Also add this particulare recipe in the CSV to store it persistently
    save_recipes_in_csv
  end

  def remove_recipe(recipe_index)
    # Allows to remove a particular recipe based on its index
    @recipes.delete_at(recipe_index)
    save_recipes_in_csv
  end

  # def scrapped_recipes_with_ingredient(ingredient, difficulty)
  #   recipes = search_recipe_with_ingredient(ingredient, difficulty)
  #   recipes.map! do |recipe|
  #     Recipe.new(recipe[:title], recipe[:description], recipe[:prep_time], difficulty)
  #   end
  #   return recipes
  # end

  def recipe_done(recipe_index)
    @recipes[recipe_index].done!
    save_recipes_in_csv
  end

  private

  # def search_recipe_with_ingredient(ingredient, difficulty)
  #   url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{ingredient}&dif=#{difficulty}"
  #   first_five_recipes = []
  #   Nokogiri::HTML(open(url), nil, 'utf-8').search('.recipe-card').first(5).each do |element|
  #     first_five_recipes << {
  #       title: element.at_css('.recipe-card__title').text.strip,
  #       description: element.at_css('.recipe-card__description').text.strip,
  #       prep_time: element.at_css('.recipe-card__duration__value').text.strip
  #     }
  #   end
  #   return first_five_recipes
  # end

  def import_csv_file(filepath)
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.foreach(filepath, csv_options) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4].match("true") ? true : false)
    end
  end

  def save_recipes_in_csv
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end
end
