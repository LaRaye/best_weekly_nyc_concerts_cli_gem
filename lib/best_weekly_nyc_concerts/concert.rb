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

  def self.find_by_location_and_list(location)
    self.all.each_with_index do |concert, index|
      if concert.location == location
        puts "#{index + 1}. #{concert.title}, #{concert.date}"
      end
    end
  end

  def self.find_by_genre_and_list(genre)
    self.all.each_with_index do |concert, index|
      if concert.genre == genre
        puts "#{index + 1}. #{concert.title}, #{concert.date}"
      end
    end
  end
end
