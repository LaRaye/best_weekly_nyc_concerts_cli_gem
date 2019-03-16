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
end
