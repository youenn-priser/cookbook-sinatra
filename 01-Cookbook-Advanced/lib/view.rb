class View
  def display_all(recipes)
    recipes.each_with_index do |recipe, index|
      if recipe.done?
        puts "#{index + 1}. [X] - #{recipe.name} (#{recipe.prep_time}): #{recipe.description}
        - #{recipe.difficulty_level}"
      else
        puts "#{index + 1}. [ ] - #{recipe.name} (#{recipe.prep_time}): #{recipe.description}
        - #{recipe.difficulty_level}"
      end
    end
  end

  def ask_for(something)
    puts "What's the #{something} of the recipe you want to add?"
    print ">"
    return gets.chomp
  end

  def ask_for_index(action)
    puts "Which recipe do you want to #{action}?"
    print ">"
    return gets.chomp.to_i - 1
  end

  def ask_for_ingredient
    puts "What ingredient would you like a recipe for?"
    print ">"
    return gets.chomp
  end

  def ask_for_difficulty_level
    puts "Which difficulty level do you seek?
    [1 = Très facile, 2 = Facile, 3 = Niveau Moyen, 4 = Difficile]"
    print ">"
    return gets.chomp
  end
end
