# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "motion-gyro-image-controller"
  spec.version       = "1.0"
  spec.authors       = ["Multunus"]
  spec.email         = ["info@multunus.com"]
  spec.summary       = %q{A controller that lets you control images using gyro}
  spec.description   = %q{RubyMotion image view controller that lets you preview images by means of tilt}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
