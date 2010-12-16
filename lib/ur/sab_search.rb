# encoding: utf-8

require 'rsolr-ext'
require File.dirname(__FILE__) + '/sab'

module UR
  class SabSearch
    # Setup
    if !defined?(SEARCH_SERVICE_URL)
      SEARCH_SERVICE_URL = 'http://services.ur.se/search'
    end

    attr_reader :solr, :sab, :subjects

    def initialize(sab_code, options = {})
      solr = RSolr.connect :url => SEARCH_SERVICE_URL
      @sab = UR::Sab.new(sab_code) unless sab_code.nil?

      response = solr.find({
        :indent => 'on',
        :qt => 'sab',
        'facet.mincount' => 1,
        'facet.limit' => -1,
        'facet.prefix' => sab_code,
        :q => '*:*',
      }.merge(options))

      # Expose the Solr response
      @solr = response

      facet_counts = Hash[*response['facet_counts']['facet_fields']['sab_subjects']]

      sorted_subjects = facet_counts.keys.sort { |l,r| r <=> l }
      reduced_facet_counts = {}

      sorted_subjects.each_index do |j|
        current_code = sorted_subjects[j]
        next_code    = sorted_subjects[j + 1]
        count        = facet_counts[current_code]

        if !next_code.nil? && current_code.match(next_code)
          if facet_counts[next_code] != count
            reduced_facet_counts[current_code] = count
          end
        else
          reduced_facet_counts[current_code] = count
        end
      end

      @subjects = reduced_facet_counts.map { |code, count|
          if (@sab.nil? && code.length == 1) ||
             (!@sab.nil? && code.length < @sab.code.length+2) ||
             (!@sab.nil? && code.match(/#{@sab.code}\.\d$/)) ||
             (!@sab.nil? && code.match(/#{@sab.code}\:\w{1,2}$/))
            sab = UR::Sab.new(code, count)
            sab if sab.text
          end
      }.compact.sort { |l,r| l.code <=> r.code }
    end
  end
end
