class DogBreeds::Dog
  attr_accessor :name, :page_url

  @@all = []

  def initialize(name, page_url)
    @name = name
    @page_url = page_url
    @@all << self
  end

  def ad_details(details)
    details.each do |k,v|
      self.send("#{k}=", v)
    end
  end

  def self.all
    @@all 
  end
end
