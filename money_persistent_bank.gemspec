# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "money_persistent_bank/version"

Gem::Specification.new do |s|
  s.name        = "money_persistent_bank"
  s.version     = MoneyPersistentBank::VERSION
  s.authors     = ["Semyon Perepelitsa"]
  s.email       = ["sema@sema.in"]
  s.homepage    = "https://github.com/semaperepelitsa/money_persistent_bank"
  s.summary     = %q{Adds persistent bank to Money gem}
  # s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "money_persistent_bank"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "money"
  s.add_dependency "activesupport"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
