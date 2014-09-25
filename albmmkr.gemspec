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
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.requirements << 'exiftool, v9.69'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_runtime_dependency "mini_exiftool"
end
