class DogBreeds::Dog
	attr_accessor :name, :page_url, :intro, :highlights, :history, :personality, :size, :care, :feeding, :children_and_other_pets

	@@all = []

	def initialize(name, page_url)
		@name = name
		@page_url = page_url
		@@all << self
	end

	def add_details(details) #takes hash returned from DogBreeds::Scraper.scrape_profile(url) and adds breed data to the corresponding instance of dog breed
		details.each do |k,v|
			self.send("#{k}=", v)
		end
	end

	def self.all
		@@all
	end
end
