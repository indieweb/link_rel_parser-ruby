# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "link_rel_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "link_rel_parser"
  spec.version       = LinkRelParser::VERSION
  spec.authors       = ["Shane Becker"]
  spec.email         = ["veganstraightedge@gmail.com"]

  spec.summary       = %q{Parse HTTP `Link` headers into a structured format}
  spec.description   = %q{Ruby port of https://github.com/indieweb/link-rel-parser-php}
  spec.homepage      = "https://github.com/indieweb/link-rel-parser-ruby"
  spec.license       = "CC0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "metainspector"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
end
