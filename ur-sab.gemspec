Gem::Specification.new do |s|
  s.name          = "ur-sab"
  s.version       = "0.1"
  s.date          = "2010-05-10"
  s.summary       = "Naive translation of SAB codes"
  s.description   = "Translates SAB codes to Swedish subject"
  s.has_rdoc      = false
  s.email         = "peter@c7.se"
  s.homepage      = "http://github.com/c7/ur-sab"
  s.authors       = ["Peter Hellberg"]
  s.licenses      = "MIT-LICENSE"
  s.files         = [
    "README.markdown",
    "MIT-LICENSE",
    "lib/ur-sab.rb",
    "lib/ur/sab.rb",
    "lib/ur/sab_codes.rb",
    "lib/ur/sab_search.rb"
  ]
  s.rubyforge_project = "ur-sab"
  
  s.add_dependency('rsolr', '>= 0.12.1')
  s.add_dependency('rsolr-ext', '>= 0.12.0')
end
