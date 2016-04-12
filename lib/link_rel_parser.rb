require "link_rel_parser/version"

module LinkRelParser
  class << self

    def parse(headers, base_url: nil)

      

      response = {
        status: "http_code",
        type: "content_type",
        rels: rels(headers, base_url: base_url)
      }
      
      response[:rels].nil? ? {} : response
    end
    
    def rels(headers, base_url: nil)
      links_rels = []
      links_rels
    end
  end
end
