class BestWeeklyNycConcerts::Concert
  @@all = []
  attr_accessor :title, :date, :location, :genre, :blurb

  def initialize(title = nil, date = nil, location = nil, genre = nil, blurb = nil)
    @title = title
    @date = date
    @location = location
    @genre = genre
    @blurb = blurb
    @@all << self
  end

  def self.all
    @@all
  end

  def self.list_concerts
    self.all.each_with_index do |concert, index|
      puts "#{index + 1}. #{concert.title}, #{concert.date}"
    end
  end

  def self.concert_info(input)
    self.all.each_with_index do |concert, index|
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

  def self.location_list
    location_arr = self.all.collect {|concert| concert.location}
    location_list = location_arr.uniq.each_with_index {|location, index| puts "#{index + 1}. #{location}"}
  end

  def self.genre_list
    genre_arr = self.all.collect {|concert| concert.genre}
    genre_list = genre_arr.uniq.each_with_index {|genre, index| puts "#{index + 1}. #{genre}"}
  end

  def self.find_by_location_and_list(location)
    counter = 0
    @location_selection_concerts = []
    self.all.each do |concert, index|
      if concert.location == location
        @location_selection_concerts << concert.title
        puts "#{counter += 1}. #{concert.title}, #{concert.date}"
      end
    end
  end

  def self.find_by_genre_and_list(genre)
    counter = 0
    @genre_selection_concerts = []
    self.all.each do |concert, index|
      if concert.genre == genre
        @genre_selection_concerts << concert.title
        puts "#{counter += 1}. #{concert.title}, #{concert.date}"
      end
    end
  end

  def self.find_and_list_from_location(input)
    title = ""

    @location_selection_concerts.each_with_index do |concert_title, index|
      if input.to_i - 1 == index
        title = concert_title
      end
    end

    self.all.each do |concert|
      if concert.title == title
        puts "#{concert.title}, #{concert.date}"
        puts ""
        puts "Playing At: #{concert.location}"
        puts ""
        puts "Genre: #{concert.genre}"
        puts ""
        puts "About: #{concert.blurb}"
      end
    end
  end

  def self.find_and_list_from_genre(input)
    title = ""

    @genre_selection_concerts.each_with_index do |concert_title, index|
      if input.to_i - 1 == index
        title = concert_title
      end
    end

    self.all.each do |concert|
      if concert.title == title
        puts "#{concert.title}, #{concert.date}"
        puts ""
        puts "Playing At: #{concert.location}"
        puts ""
        puts "Genre: #{concert.genre}"
        puts ""
        puts "About: #{concert.blurb}"
      end
    end
  end
end
