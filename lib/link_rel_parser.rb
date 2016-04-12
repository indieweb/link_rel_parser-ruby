require "link_rel_parser/version"
require "active_support"
require "active_support/core_ext/object/blank"

module LinkRelParser
  class << self

    def parse(headers, base_url: nil)
      response = {
        status: "http_code",
        type: "content_type",
        rels: http_rels(headers, base_url: base_url)
      }
      
      response[:rels].blank? ? {} : response
    end

    # Internal: Parse out the HTTP LINK headers with a REL value.
    #
    # headers  - string to HTTP headers.
    # base_url - optional base URL to resolve relative URLs (default: nil).
    #
    # Examples
    #
    #   http_rels(headers)
    #   # => 'TomTomTomTom'
    #
    # Returns an array of key/value pairs of LINK name and REL value or an empty array
    def http_rels(headers, base_url: nil)
      links_rels = [headers]

      links_rels
    end
  end
end
