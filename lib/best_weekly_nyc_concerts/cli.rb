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
        more_info
      when "2"
        location_list
        list_by_location
      when "3"
        list_by_genre
        more_info
      when "exit"
        goodbye
      else
        puts "Sorry, that's not a valid entry. Choose a number from above or enter 'exit'."
      end
    end
    puts ""
  end

  def goodbye
    puts ""
    puts "Thanks for checking out this week's roundup of the best NYC concerts!"
  end

  #work on this loop
  def more_info
    puts ""
    puts "Choose a number to learn more. Enter 'menu' to return to the menu or 'exit':"

    input = gets.strip.downcase

    if input == "menu"
      menu
    elsif input == "exit"
      goodbye
    elsif input.to_i > 0
      input = input.to_i
      concert_info(input)
      select_another
    else
      puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
    end
  end

  def list_concerts
    puts ""
    puts "The Best Concerts in NYC This Week:"
    BestWeeklyNycConcerts::Concert.all.each_with_index do |concert, index|
      puts "#{index + 1}. #{concert.title}, #{concert.date}"
    end
  end

  def concert_info(input)
    input = input
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
    input = gets.strip.downcase

    if input == "yes"
      list_concerts
      more_info
    elsif input == "no"
      menu
    else
      puts "Sorry, that's not a valid entry. Choose a number from above, enter 'menu' or enter 'exit'."
    end
  end

  #not working
  def location_list
    puts ""
    puts "Below are the locations for all of this week's concerts:"
    puts ""
    location_arr = BestWeeklyNycConcerts::Concert.all.collect {|concert| concert.location}
    @location_list = location_arr.uniq.each_with_index {|location, index| puts "#{index + 1}. #{location}"}
  end

  def list_by_location
    puts ""
    puts "Enter the number of the location to see the concert(s) playing there:"
    input = gets.strip.to_i
    location = ""
    @location_list.each_with_index do |loc, index|
      if input - 1 == index
        location = loc
      end
    end

    BestWeeklyNycConcerts::Concert.all.each_with_index do |concert, index|
      if concert.location == location
        puts "#{index + 1}. #{concert.title}, #{concert.date}"
      end
    end
  end

  def list_by_genre
    puts "genre list"
  end
end
