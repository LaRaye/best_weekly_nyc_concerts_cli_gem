class BestWeeklyNycConcerts::Concert_Scraper

  def get_page
    doc = Nokogiri::HTML(open("https://www.timeout.com/newyork/music/the-best-concerts-in-nyc-this-week"))
    binding.pry

    #title = doc.css(".card-content").first.css("h3").text.strip
    #location = doc.css(".card-content").first.css("span.bold").text.strip
    #genre = doc.css(".card-content").first.css(".category").text.strip
    #date = doc.css(".card-content").first.css("time.bold").text.strip
    #blurb = doc.css(".card-content").first.css(".js-card-desc-content").text.strip
  end
end
