# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "eth_watcher/version"

Gem::Specification.new do |spec|
  spec.name          = "eth_watcher"
  spec.version       = EthWatcher::VERSION
  spec.authors       = ["Kent 'picat' Gruber"]
  spec.email         = ["kgruber1@emich.edu"]

  spec.summary       = %q{A threaded command-line application to monitor network packets for hardware addresses in ethernet headers.}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/picatz/eth_watcher"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = 'bin'
  spec.executable    = "eth_watcher"
  spec.require_paths = ['lib']

  spec.add_dependency "packetgen", '~> 1.4.3'
  spec.add_dependency "trollop",   '2.1.2'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
