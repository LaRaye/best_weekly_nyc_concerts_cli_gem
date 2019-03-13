class BestWeeklyNycConcerts::CLI

  def call
    puts "Welcome to this week's roundup of the best concerts in NYC!"
    menu
  end

  def menu
    puts "What would you like to do? Choose a number from the following or enter 'exit':"
    puts <<-DOC.gsub /^\s*/, ''
      1. See the complete list of this week's concerts
      2. Search for concerts by location
      3. Search for concerts by genre
    DOC
    menu_selection
  end

  def menu_selection
    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        list_concerts
        more_info
      when "2"
        list_by_location
        more_info
      when "3"
        list_by_genre
        more_info
      when "exit"
        goodbye
      else
        puts "Sorry, that's not a valid entry. Choose a number from above or enter 'exit'."
      end
    end
  end

  def goodbye
    puts "Thanks for checking out this week's roundup of the best NYC concerts!"
  end

  def more_info
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"

    input = nil
    while input != "exit"
      input = gets.strip.downcase
      case input
      when "1"
        concert_info
        menu
      when "menu"
        menu
      end
    end
    goodbye
  end

  def list_concerts
    puts "concert list"
  end

  def list_by_location
    puts "location list"
  end

  def list_by_genre
    puts "genre list"
  end

  def concert_info
    puts "will provide all info for single concert"
  end
end
