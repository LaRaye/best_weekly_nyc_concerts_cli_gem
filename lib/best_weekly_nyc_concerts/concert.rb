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

  def self.all
    @@all
  end


end
