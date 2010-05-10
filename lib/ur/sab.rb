require File.dirname(__FILE__) + '/sab_codes'

module UR
  class Sab
    attr_reader :code, :text, :count
    
    def initialize(code, count = nil)
      @code = code
      @text = UR::Sab::translate(code)
      @count = count
    end
    
    def parents
      sab_parents = []
      
      if code
        tmp = ''
        parts = code.split('')
      
        parts.pop
      
        sab_parents = parts.map {|p| 
          UR::Sab.new(tmp += p) unless p.match(/(\.|\:)/)
        }.compact
      end
      
      sab_parents
    end
    
    def self.translate(code)
      UR::SAB_CODES.has_key?(code) ? SAB_CODES[code] : false
    end
  end
end