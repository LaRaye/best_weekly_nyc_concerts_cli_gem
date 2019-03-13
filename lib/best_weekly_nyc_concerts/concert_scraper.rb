class BestWeeklyNycConcerts::Concert_Scraper

  def get_page
    doc = Nokogiri::HTML(open("https://www.timeout.com/newyork/music/the-best-concerts-in-nyc-this-week"))
    binding.pry
  end
end
