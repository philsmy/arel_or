# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "arel_or/version"

Gem::Specification.new do |s|
  s.name        = "arel_or"
  s.version     = ArelOr::VERSION
  s.authors     = ["Phil Smy"]
  s.email       = ["phil@philsmy.com"]
  s.homepage    = ""
  s.summary     = "Port fake_arel's or to rails3"
  s.description = "Port fake_arel's or to rails3"

  s.rubyforge_project = "arel_or"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
