
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dog_breeds/version"

Gem::Specification.new do |spec|
  spec.name          = "dog_breeds"
  spec.version       = DogBreeds::VERSION
  spec.authors       = ["'Frederico  Morato'"]
  spec.email         = ["'freddymorato@gmail.com'"]

  spec.summary       = %q{A gem that provides information on different dog breeds}
  spec.homepage      = "https://github.com/Freddymorato/dog-breeds-cli-gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables << 'dog-breeds'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri"
end
