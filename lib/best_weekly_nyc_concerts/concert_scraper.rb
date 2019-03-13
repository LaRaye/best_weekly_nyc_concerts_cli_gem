class BestWeeklyNycConcerts::Concert_Scraper

  def get_page
    Nokogiri::HTML(open("https://www.timeout.com/newyork/music/the-best-concerts-in-nyc-this-week"))
  end 
end
