class DogBreeds::CLI

	BASE_PATH = "https://dogtime.com"

	def call
		puts ""
		puts "*|*----------------------------------------*|*"
		puts "             *** DOG BREEDS *** 		      		"
		puts "*|*----------------------------------------*|*"
		breeds = make_dogs
		@i = 0
		@j = 9
		list_dogs(breeds)
	end

	def make_dogs #Scrapes site index page to gather all of the breeds and breed urls
		breeds_array = DogBreeds::Scraper.scrape_index(BASE_PATH + "/dog-breeds/profiles")
		breeds_array.collect do |breed|
			DogBreeds::Dog.new(breed[:name], breed[:page_url])
		end
	end

	def list_dogs(breeds) #indexes through array of dog breeds returned from make_dogs and lists each one for user to select from
		puts ""
		breeds[@i..@i+@j].each.with_index(@i + 1) {|b,i|puts "[#{i}] #{b.name}"}
		puts "[all]" if @j != 209
		puts "[less]" if @j == 209
		puts "[next]" if @i == 0 && @j == 9
		puts "[back||next]" if @i >= 10 && @i+@j < 209
		puts "[back]" if @i+@j >= 209 && @j == 9
		puts ""
		puts "type [exit] at any time to close"
		puts ""
		puts "Enter the dog breed or number that you would like to learn more about:"
		input = gets.strip
		if input.to_i > 0 && input.to_i <= breeds.length
			view_breed_overview(DogBreeds::Dog.all[input.to_i - 1])
		elsif DogBreeds::Dog.all.detect{|breed|breed.name.downcase == input.downcase}
			view_breed_overview(DogBreeds::Dog.all.detect{|breed| breed.name.downcase == input.downcase})
		elsif input.downcase == "all"
			@i = 0
			@j = 209
			list_dogs(breeds)
		elsif input.downcase == "less"
			@i = 0
			@j = 9
			list_dogs(breeds)
		elsif input.downcase == "next" && @i+@j == 209
			puts ""
			puts "That's all the dog breeds!"
			list_dogs(breeds)
		elsif input.downcase == "next"
			@i += 10
			list_dogs(breeds)
		elsif input.downcase == "back" && @i == 0
			puts ""
			puts "That's all the dog breeds!"
			list_dogs(breeds)
		elsif input.downcase == "back"
			@i -= 10
			list_dogs(breeds)
		elsif input.downcase == "exit"
			self.goodbye
		else
			puts ""
			puts "Invalid Input. Please try again."
			self.list_dogs(breeds)
		end
	end

	def view_breed_overview(breed) #upon selecting a specific dog breed, this method scrapes that breed's url page for more information
		details = DogBreeds::Scraper.scrape_profile(breed.page_url)
		breed.add_details(details)
		puts ""
		puts "*|*-------------------------------------------------------------------*|*"
		puts "	#{breed.name}																													 "
		puts "*|*-------------------------------------------------------------------*|*"
		puts ""
		puts "#{breed.intro}"
		puts ""
		puts "Size: #{breed.size}"
		puts ""
		view_more_details(breed)
	end

	def view_more_details(breed) #after more info is scraped from view_breed_overview, more options are presented to learn more about breed
		puts ""
		puts "Learn more about the #{breed.name}:"
		puts "[1] Highlights"
		puts "[2] History"
		puts "[3] Personality"
		puts "[4] Care"
		puts "[5] Feeding"
		puts "[6] Children And Other Pets"
		puts "[Back] to list of all dog breeds"
		input = gets.strip
		topic = nil
		info = nil
		case input.downcase
		when "1","highlights"
			topic = "Highlights"
			info = breed.highlights
		when "2","history"
			topic = "History"
			info = breed.history
		when "3","personality"
			topic = "Personality"
			info = breed.personality
		when "4","care"
			topic = "Care"
			info = breed.care
		when "5","feeding"
			topic = "Feeding"
			info = breed.feeding
		when "6","children and other pets"
			topic = "Children And Other Pets"
			info = breed.children_and_other_pets
		when "back"
			call
		when "exit"
			goodbye
		else
			puts ""
			puts "Invalid Input. Please try again."
			view_more_details(breed)
		end
		view_topic(breed, topic, info)
	end

	def view_topic(breed, topic, info) #once specific topic is selected, more information on that topic is presented to the user
		puts ""
		puts "*|*-------------------------------------------------------------------*|*"
		puts "	#{breed.name} - #{topic}																							 "
		puts "*|*-------------------------------------------------------------------*|*"
		puts ""
		if info.is_a?(String)
			puts "#{info}"
		else
			puts "Sorry, there's no info for #{breed.name} on this topic. Please try again."
			view_more_details(breed)
		end
		puts ""
		puts "[1] Learn more about the #{breed.name}"
		puts "[2] Learn about a different dog breed"
		input = gets.strip
		case input.downcase
		when "1"
			view_more_details(breed)
		when "2"
			call
		when "exit"
			goodbye
		else
			puts ""
			puts "Invalid Input. Please try again."
			view_topic(breed, topic, info)
		end
	end

	def goodbye #upon exiting the program, the user is presented a thank you and dog artwork
    puts ""
		puts "*|*----------------------------------------*|*"
		puts " 	Thanks for learning about dogs!						"
		puts "*|*----------------------------------------*|*"
		puts ""
		puts "                         	"
		puts "        ,-~~~~-,         	"
		puts "  .-~~~;        ;~~~-.   	"
		puts " /    /          \    \  	"
		puts "{   .'{  O    O  }'.   } 	"
		puts " `~`  { .-~~~~-. }  `~`  	"
		puts "      ;/        \;       	"
		puts "     /'._  ()  _.'\      	"
		puts "    /    `~~~~`    \     	"
		puts "   ;                ;    	"
		puts "   {                }    	"
		puts "   {     }    {     }    	"
		puts "   {     }    {     }    	"
		puts "   /     \    /     \    	"
		puts "  { { {   }~~{   } } }   	"
		puts "   `~~~~~`    `~~~~~`    	"
		puts ""
		exit
	end
end
