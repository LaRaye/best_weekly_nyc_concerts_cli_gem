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
      when "1"
        list_concerts
        more_info_and_select_another
        goodbye
      when "2"
        location_list
        list_by_location
        more_info
      when "3"
        genre_list
        list_by_genre
        more_info
      when "exit"
        break
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
    BestWeeklyNycConcerts::Concert.all.each_with_index do |concert, index|
      puts "#{index + 1}. #{concert.title}, #{concert.date}"
    end
  end

  def more_info_and_select_another
    puts ""
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"
    input = nil

    while input != "exit"
      input = gets.strip.downcase
      if input == "menu"
        menu
      elsif input.to_i > 0
        concert_info(input)
        select_another
      elsif input == "exit"
        break
      else
        puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
      end
    end
    goodbye
    exit
  end

  def more_info
    puts ""
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"
    input = nil

    while input != "exit"
      input = gets.strip.downcase
      if input == "menu"
        menu
      elsif input.to_i > 0
        concert_info(input)
        menu
      elsif input == "exit"
        break
      else
        puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
      end
    end
    goodbye
    exit
  end

  def concert_info(input)
    input = input.to_i
    BestWeeklyNycConcerts::Concert.all.each_with_index do |concert, index|
      if input - 1 == index
        puts ""
        puts "#{index + 1}. #{concert.title}, #{concert.date}"
        puts ""
        puts "Playing At: #{concert.location}"
        puts ""
        puts "Genre: #{concert.genre}"
        puts ""
        puts "About: #{concert.blurb}"
      end
    end
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
      elsif input == "no"
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
    location_arr = BestWeeklyNycConcerts::Concert.all.collect {|concert| concert.location}
    @location_list = location_arr.uniq.each_with_index {|location, index| puts "#{index + 1}. #{location}"}
  end

  def list_by_location
    puts ""
    puts "Enter the number of the location to see the concert(s) available or 'exit' to return to menu:"

    input = ""
    location = ""

    while input != "exit"
      input = gets.strip.downcase
      if input.to_i.between?(1, @location_list.length)
        @location_list.each_with_index do |loc, index|
          if input.to_i - 1 == index
            location = loc
          end
        end

        puts "Here is the concert(s) for that location:"
        puts ""

        BestWeeklyNycConcerts::Concert.all.each_with_index do |concert, index|
          if concert.location == location
            puts "#{index + 1}. #{concert.title}, #{concert.date}"
          end
        end
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
    genre_arr = BestWeeklyNycConcerts::Concert.all.collect {|concert| concert.genre}
    @genre_list = genre_arr.uniq.each_with_index {|genre, index| puts "#{index + 1}. #{genre}"}
  end

  def list_by_genre
    puts ""
    puts "Enter the number of the genre to see the concert(s) available or 'exit' to return to menu:"

    input = ""
    genre = ""

    while input != "exit"
      input = gets.strip.downcase
      if input.to_i.between?(1, @genre_list.length)
        @genre_list.each_with_index do |gen, index|
          if input.to_i - 1 == index
            genre = gen
          end
        end

        puts "Here is the concert(s) for that genre:"
        puts ""

        BestWeeklyNycConcerts::Concert.all.each_with_index do |concert, index|
          if concert.genre == genre
            puts "#{index + 1}. #{concert.title}, #{concert.date}"
          end
        end
        break
      elsif input == "exit"
        menu
      else
        puts "Sorry, that is not a valid entry. Choose a number or enter 'exit' to return to menu"
        genre_list
      end
    end
  end

end
