# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid_alphadog/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_alphadog"
  s.version     = MongoidAlphadog::VERSION
  s.authors     = ["Matt Patterson", "Lone Star Internet"]
  s.email       = ["mpatterson@lone-star.net"]
  s.homepage    = "https://github.com/LoneStarInternet/mongoid_alphadog"
  s.summary     = %q{Case-insensitive alphabetizing for Mongoid document models}
  s.description = %q{A simple little gem that makes it easy to handle case-insensitive alphabetizing for Mongoid document models}

  s.rubyforge_project = "mongoid_alphadog"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<mongoid>, [">= 2.0.2"])
  s.add_runtime_dependency(%q<rdoc>, [">= 2.5.11"])
  
  s.add_development_dependency(%q<bson_ext>, [">= 1.3.1"])
  s.add_development_dependency(%q<rspec-core>, [">= 2.6.3"])
  s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
  s.add_development_dependency(%q<database_cleaner>, [">= 0.6.7"])
  s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
  s.add_development_dependency(%q<jeweler>, ["~> 1.6.0"])
end
