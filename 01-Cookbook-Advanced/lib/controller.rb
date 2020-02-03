require_relative 'view'
require_relative 'scrape_marmiton'
class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # Method to list all our recipe of our cookbook
    recipes = @cookbook.all
    @view.display_all(recipes)
  end

  def create
    # Method to create a nex recipe
    # May call methods defined in other classes
    name = @view.ask_for("name")
    description = @view.ask_for("description")
    prep_time = @view.ask_for("preparation time")
    @cookbook.add_recipe(Recipe.new(name, description, prep_time))
  end

  def destroy
    # Method to delete a recipe from our cookbook
    # May call methods defined in other classes
    list
    recipe_index = @view.ask_for_index("delete")
    @cookbook.remove_recipe(recipe_index)
  end

  def search_recipe
    ingredient = @view.ask_for_ingredient
    difficulty = @view.ask_for_difficulty_level
    recipes = ScrapeMarmiton.new(ingredient, difficulty).call
    @view.display_all(recipes)
    index = @view.ask_for_index("add")
    @cookbook.add_recipe(recipes[index])
  end

  def mark_as_done
    list
    recipe_index = @view.ask_for_index("mark as done")
    @cookbook.recipe_done(recipe_index)
    list
  end
end
