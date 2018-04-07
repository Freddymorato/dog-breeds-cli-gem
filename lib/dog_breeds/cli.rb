class DogBreeds::CLI

	BASE_PATH = "http://dogtime.com"

	def call
	puts ""
	puts "*|*----------------------------------------*|*"
	puts "             *** DOG BREEDS *** 		      		"
	puts "*|*----------------------------------------*|*"
	breeds = make_dogs
	list_dogs(breeds)
end

	def make_dogs
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
	end

	def view_breed_overview(breed)
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
