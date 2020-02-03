class Recipe
  attr_reader :name, :description, :prep_time, :difficulty_level, :difficulty
  attr_accessor :done
  def initialize(name, description, prep_time = "~15 min", difficulty = "0", done = false)
    @name        = name
    @description = description
    @prep_time   = prep_time
    @done        = done
    @difficulty  = difficulty
    @difficulty_level = translate_difficulty
  end

  def translate_difficulty
    case @difficulty
    when "1" then "Très facile"
    when "2" then "Facile"
    when "3" then "Niveau Moyen"
    when "4" then "Difficile"
    else
      "Difficulté non définie"
    end
  end

  def done!
    @done = true
  end

  def done?
    return @done
  end
end
