# UR::Sab

Naive translation of SAB codes

### Installation
    gem install ur-sab
    
#### Examples
    require 'ur-sab'
    
    search = UR::SabSearch.new('C')
    
    search.sab.text #=> "Religion"
    search.subjects.last.count #=> 2