require "link_rel_parser/version"
require "active_support"
require "active_support/core_ext/object/blank"

module LinkRelParser
  class << self

    # Public: Parse out headers: HTTP status code, content type, and LINKs with a REL value.
    #
    # headers  - string to HTTP headers.
    # base_url - optional base URL to resolve relative URLs (default: nil).
    #
    # Examples
    #
    #   LinkRelParser.parse(headers)
    #   # =>
    #     {
    #       status: "200",
    #       type:   "text/HTML",
    #       rels:   { "X-Pingback" => "http://www.example.com/xmlrpc.php", "indieauth" => "https://indieauth.com" }
    #     }
    #
    # Returns an array of key/value pairs of LINK name and REL value or an empty array
    def parse(headers, base_url: nil)
      # TODO
      response = {
        status: "200",
        type:   "text/HTML",
        rels:   http_rels(headers, base_url: base_url)
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
    #   # => { "X-Pingback" => "http://www.example.com/xmlrpc.php", "indieauth" => "https://indieauth.com" }
    #
    # Returns a hash of LINK name and REL value or an empty {}
    def http_rels(headers, base_url: nil)
      return {} if headers.blank?

      # clean up and normal headers
      headers = headers.strip.gsub(/\r\n|\r/, "\n").
                              gsub(/\t+/, " ").
                              gsub(/^\s+/, "").
                              split("\n")

      links_rels = {}
      headers.each do |header|
        header.sub!(/Link: /i, "Link: ")

        if header =~ /X-Pingback:/
          # convert to a Link header and have common code handle it
          header = %Q{Link: <#{ header.split('X-Pingback: ').last }>; rel="pingback"}
        end

        if header =~ /Link:/
          links = header.split("Link: ").last.strip.split(", ")
          links.each do |link|
            href_and_rel = link.split("; ")
            href = href_and_rel.first.gsub(/<|>/, "")

            rels = []
            href_and_rel.each do |rel_value|
              if rel_value =~ /rel=/
                rels = rel_value.gsub(/"|'/, "").split("rel=").last.strip.split
              end
            end

            # ignore Link: headers without rel
            unless rels.blank?
              rels.each do |rel|
                unless rel.blank?
                  rel = rel.downcase.strip

                  if links_rels[rel].blank?
                    links_rels[rel] = ""
                  end

                  unless base_url.blank?
                    href = base_url + href # TODO use standard library for this
                  end

                  # TODO is this necessary?
                  unless links_rels[rel].include?(href)
                    links_rels[rel] << href
                  end
                end
              end
            end

          end
        end
      end

      links_rels
    end

  end
end
