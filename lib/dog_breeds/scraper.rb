class DogBreeds::Scraper

	def self.scrape_index(url) 
		dog_breeds = []
		doc = Nokogiri::HTML(open(url))
		breeds = doc.css(".group-list-item .post-title")

		breeds.each do |b|
			breed = {}
			breed[:name] = b.text
			breed[:page_url] = b.attr("href")
			dog_breeds << breed
		end
		dog_breeds
	end

  def self.scrape_profile(url)
    doc = Nokogiri::HTML(open(url))
  end
end
