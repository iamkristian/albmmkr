# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'albmmkr/version'

Gem::Specification.new do |spec|
  spec.name          = "albmmkr"
  spec.version       = Albmmkr::VERSION
  spec.authors       = ["Kristian Rasmussen"]
  spec.email         = ["me@krx.io"]
  spec.summary       = %q{Sorts jpg's into albums}
  spec.description   = %q{Will sort a directory of jpg files into albums, based on exif and date.}
  spec.homepage      = "http://github.com/iamkristian/albmmkr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.requirements << 'exiftool, v9.69'
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_runtime_dependency "mini_exiftool", "~> 2.4"
  spec.add_runtime_dependency "progressbar", "~> 0.21"
  spec.add_runtime_dependency "columnize", "~> 0.8"
end
