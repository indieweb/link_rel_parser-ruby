require "link_rel_parser/version"
require "active_support"
require "active_support/core_ext/object/blank"

module LinkRelParser
  class << self

    def parse(headers, base_url: nil)
      response = {
        status: "http_code",
        type: "content_type",
        rels: rels(headers, base_url: base_url)
      }
      
      response[:rels].blank? ? {} : response
    end
    
    def rels(headers, base_url: nil)
      links_rels = [headers]

      links_rels
    end
  end
end
