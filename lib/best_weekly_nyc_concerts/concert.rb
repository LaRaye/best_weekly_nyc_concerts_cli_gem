class BestWeeklyNycConcerts::Concert
  @@all = []
  attr_accessor :title, :date, :location, :genre, :blurb, :url

  def initialize(title = nil, date = nil, location = nil, genre = nil, blurb = nil, url = nil)
    @title = title
    @date = date
    @location = location
    @genre = genre
    @blurb = blurb
    @url = url 
    @@all << self
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
