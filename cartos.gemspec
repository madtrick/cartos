# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cartos/version'

Gem::Specification.new do |spec|
  spec.name          = "cartos"
  spec.version       = Cartos::VERSION
  spec.authors       = ["Farruco Sanjurjo"]
  spec.email         = ["farruco.sanjurjo@gmail.com"]
  spec.description   = <<-EOF
    Cartos is litle gem for loading into Google Spreadsheet data exported from Cashbase (https://www.cashbasehq.com/) for further analysis
    EOF
  spec.summary       = %q{Load Cashbase exports into Google Spreadsheet}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "nokogiri", "1.5.0"
  spec.add_dependency "google_drive"
  spec.add_dependency "sugarfree-config"
  spec.add_dependency "logging"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
