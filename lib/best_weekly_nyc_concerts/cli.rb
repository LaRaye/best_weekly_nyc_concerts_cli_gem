class BestWeeklyNycConcerts::CLI

  def call
    BestWeeklyNycConcerts::Concert_Scraper.new.create_concerts
    puts ""
    puts "Welcome to the roundup of the best concerts in NYC this week!"
    menu
  end

  def menu
    puts ""
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
      when "exit"
        break
      when "1"
        list_concerts
        more_info_and_select_another
      when "2"
        location_list
        list_by_location
        more_info_by_location
      when "3"
        genre_list
        list_by_genre
        more_info_by_genre
      else
        puts "Sorry, that's not a valid entry. Choose a number from above or enter 'exit'."
      end
    end
    goodbye
    exit
  end

  def goodbye
    puts ""
    puts "Thanks for checking out this week's roundup of the best NYC concerts!"
  end

  def list_concerts
    puts ""
    puts "The Best Concerts in NYC This Week:"
    BestWeeklyNycConcerts::Concert.list_concerts
  end

  def more_info_and_select_another
    puts ""
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"
    input = nil

    while input != "exit"
      input = gets.strip.downcase
      if input == "exit"
        break
      elsif input == "menu"
        menu
      elsif input.to_i.between?(1, self.list_concerts.length)
        concert_info(input)
        select_another
      else
        puts ""
        puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
      end
    end
    goodbye
    exit
  end

  def more_info_by_location
    puts ""
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"
    input = nil

    while input != "exit"
      input = gets.strip.downcase
      if input == "exit"
        break
      elsif input == "menu"
        menu
      elsif input.to_i.between?(1, @location_selection_concerts.length)#input.to_i > 0
        BestWeeklyNycConcerts::Concert.find_and_list_from_location(input)
        menu
      else
        puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
      end
    end
    goodbye
    exit
  end

  def more_info_by_genre
    puts ""
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"
    input = nil

    while input != "exit"
      input = gets.strip.downcase
      if input == "exit"
        break
      elsif input == "menu"
        menu
      elsif input.to_i.between?(1, @genre_selection_concerts.length)
        BestWeeklyNycConcerts::Concert.find_and_list_from_genre(input)
        menu
      else
        puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
      end
    end
    goodbye
    exit
  end

  def concert_info(input)
    input = input.to_i
    BestWeeklyNycConcerts::Concert.concert_info(input)
  end

  def concert_info_by_title(title)
    BestWeeklyNycConcerts::Concert.find_by_title_and_list(title)
  end

  def select_another
    puts ""
    puts "Would you like to see another concert from the list? Yes/No"
    input = ""

    while input != "exit"
      input = gets.strip.downcase
      if input == "yes"
        list_concerts
        more_info_and_select_another
      elsif input == "no" || input == "exit"
        menu
      else
        puts "Sorry, that's not a valid entry. Please enter Yes/No."
      end
    end
    exit
  end

  def location_list
    puts ""
    puts "Below are the locations for all of this week's concerts:"
    puts ""
    @location_list = BestWeeklyNycConcerts::Concert.location_list
  end

  def list_by_location
    puts ""
    puts "Enter the number of the location to see the concert(s) available or 'exit' to return to menu:"

    input = ""
    @location = ""

    while input != "exit"
      input = gets.strip.downcase
      if input.to_i.between?(1, @location_list.length)
        grab_location_from_input(input)
        puts "Here is the concert(s) for #{@location}:"
        puts ""
        @location_selection_concerts = BestWeeklyNycConcerts::Concert.find_by_location_and_list(@location)
        break
      elsif input == "exit"
        menu
      else
        puts "Sorry, that is not a valid entry."
        location_list
      end
    end
  end

  def genre_list
    puts ""
    puts "Below are the different genres for all of this week's concerts:"
    puts ""
    @genre_list = BestWeeklyNycConcerts::Concert.genre_list
  end

  def list_by_genre
    puts ""
    puts "Enter the number of the genre to see the concert(s) available or 'exit' to return to menu:"

    input = ""
    @genre = ""

    while input != "exit"
      input = gets.strip.downcase
      if input.to_i.between?(1, @genre_list.length)
        grab_genre_from_input(input)
        puts "Here is the concert(s) for #{@genre}:"
        puts ""
        @genre_selection_concerts = BestWeeklyNycConcerts::Concert.find_by_genre_and_list(@genre)
        break
      elsif input == "exit"
        menu
      else
        puts "Sorry, that is not a valid entry. Choose a number or enter 'exit' to return to menu"
        genre_list
      end
    end
  end

  def grab_location_from_input(input)
    @location_list.each_with_index do |loc, index|
      if input.to_i - 1 == index
        @location = loc
      end
    end
    @location
  end

  def grab_genre_from_input(input)
    @genre_list.each_with_index do |gen, index|
      if input.to_i - 1 == index
        @genre = gen
      end
    end
    @genre
  end

end
