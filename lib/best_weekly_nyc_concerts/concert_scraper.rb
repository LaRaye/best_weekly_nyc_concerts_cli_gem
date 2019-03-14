class BestWeeklyNycConcerts::Concert_Scraper

  def get_page
    @doc = Nokogiri::HTML(open("https://www.timeout.com/newyork/music/the-best-concerts-in-nyc-this-week"))

    @doc.css(".card-content").each do |concert_listing|
     concert = BestWeeklyNycConcerts::Concert.new
     concert.title = concert_listing.css("h3").text.strip
     concert.location = concert_listing.css("span.bold").text.strip
     concert.date = concert_listing.css("time.bold").text.strip
     concert.genre = concert_listing.css(".category").text.strip
     concert.blurb = concert_listing.css(".js-card-desc-content").text.strip
    end
  end

end
