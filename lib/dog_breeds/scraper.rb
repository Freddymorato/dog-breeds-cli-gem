class DogBreeds::Scraper

  def self.scrape_index(url)
    dog_breeds = []
    doc = Nokogiri::HTML(open(url))
  end

  def self.scrape_profile(url)
    doc = Nokogiri::HTML(open(url)) 
  end
end
