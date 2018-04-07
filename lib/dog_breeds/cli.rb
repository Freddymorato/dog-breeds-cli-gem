class DogBreeds::CLI

	BASE_PATH = "http://dogtime.com"

	def call
		breeds = make_dogs
		list_dogs(breeds)
	end

	def make_dogs
		breeds_array = DogBreeds::Scraper.scrape_index(BASE_PATH + "/dog-breeds/profiles")
		breeds_array.collect do |breed|
				DogBreeds::Dog.new(breed[:name], breed[:page_url])
			end
	end

	def list_dogs
	end

	def view_breed_overview(breed)
	end

	def view_more_details(breed)
	end

	def view_topic()
	end

	def goodbye
	end
end
