class DogBreeds::CLI

	BASE_PATH = "http://dogtime.com"

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

	def make_dogs
		breeds_array = DogBreeds::Scraper.scrape_index(BASE_PATH + "/dog-breeds/profiles")
		breeds_array.collect do |breed|
			DogBreeds::Dog.new(breed[:name], breed[:page_url])
		end
	end

	def list_dogs(breeds)
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

	def view_breed_overview(breed) 
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

	def view_more_details(breed)
	end

	def view_topic()
	end

	def goodbye
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
