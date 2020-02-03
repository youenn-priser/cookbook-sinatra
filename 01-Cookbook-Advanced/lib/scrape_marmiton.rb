class ScrapeMarmiton
  def initialize(ingredient, difficulty)
    @ingredient = ingredient
    @difficulty = difficulty
    @first_five_recipes = []
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    scrapped_recipes_with_ingredient
  end

  private

  def scrapped_recipes_with_ingredient
    first_five_recipes = search_recipe_with_ingredient
    first_five_recipes.map! do |recipe|
      Recipe.new(recipe[:title], recipe[:description], recipe[:prep_time], @difficulty)
    end
  end

  def search_recipe_with_ingredient
    url = "https://www.marmiton.org/recettes/recherche.aspx?aqt=#{@ingredient}&dif=#{@difficulty}"
    first_five_recipes = []
    Nokogiri::HTML(open(url), nil, 'utf-8').search('.recipe-card').first(5).each do |element|
      first_five_recipes << {
        title: element.at_css('.recipe-card__title').text.strip,
        description: element.at_css('.recipe-card__description').text.strip,
        prep_time: element.at_css('.recipe-card__duration__value').text.strip
      }
    end
    return first_five_recipes
  end
end
