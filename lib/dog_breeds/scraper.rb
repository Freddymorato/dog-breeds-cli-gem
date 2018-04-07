class DogBreeds::Scraper

	def self.scrape_index(url) #creates and returns an array of hashes which contain dog breeds and page urls
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

	def self.scrape_profile(url) #creates and returns a hash of a dog breed with more information for the user to view
		doc = Nokogiri::HTML(open(url))
		attributes = {}

		y = doc.css("header p")
		y.each do |x|
			attributes[:intro] = x.text if x.text.include? "dog breed"
		end

		list = doc.css(".breed-data-item.js-accordion-item.item-expandable-content")
		list.each do |i|
			if i.css("h2").text.include? "Highlights"
				 attributes[:highlights] = i.css("div").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 elsif i.css("h2").text.include? "History"
				 attributes[:history] = i.css("div").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 elsif i.css("h2").text.include? "Size"
				 attributes[:size] = i.css(".breed-data-item-content.js-breed-data-section").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 elsif i.css("h2").text.include? "Personality"
				 attributes[:personality] = i.css("div").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 elsif i.css("h2").text.include? "Care"
				 attributes[:care] = i.css("div").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 elsif i.css("h2").text.include? "Feeding"
				 attributes[:feeding] = i.css(".breed-data-item-content.js-breed-data-section").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 elsif i.css("h2").text.include? "Children And Other Pets"
				 attributes[:children_and_other_pets] = i.css("div").text.gsub("\n","").gsub("\t","").gsub("\r","").gsub("\"","")
			 else
				 nil
			 end
		 end
		attributes
	end
end
