require "active_support"
require "active_support/core_ext/object/blank"
require "link_rel_parser/version"
require "metainspector"
require "uri"

module LinkRelParser
  class << self

    # Public: Parse out LINK headers with a REL value.
    #
    # url - URL to get HTTP HEAD Link (and effective/x-extended) rels.
    #
    # Examples
    #
    #   LinkRelParser.parse("http://example.com")
    #   # =>
    #     {
    #       status: "200",
    #       type:   "text/HTML",
    #       rels:   { "pingback" => "http://www.example.com/xmlrpc.php", "indieauth" => "https://indieauth.com" }
    #     }
    #
    # Returns a hash of HTTP status code, content type, and LINKs with a REL value or an empty {}
    def parse(url)
      page         = MetaInspector.new(url)
      header_links = page.response.headers[:link]

      # Convert X-Pingback to a Link header and have common code handle it
      unless page.response.headers["x-pingback"].nil?
        header_links << %Q{, <#{header_links['x-pingback']}>; rel="pingback"}
      end

      output = {
        status: page.response.status,
        type:   page.response["content-type"],
        rels:   link_rels(header_links)
      }

      output[:rels].blank? ? {} : output
    end

    # Internal: Parse out the HTTP LINK headers with a REL value.
    #
    # headers  - string to HTTP headers.
    # base_url - optional base URL to resolve relative URLs (default: nil).
    #
    # Examples
    #
    #   link_rels(headers)
    #   # => { "pingback" => "http://www.example.com/xmlrpc.php", "indieauth" => "https://indieauth.com" }
    #
    # Returns a hash of LINK name and REL value or an empty {}
    def link_rels(headers, base_url: nil)
      links = {}

      unless headers.nil?
        headers.split(", ").each do |link, index|
          section = link.split(';')
          url     = section[0][/<(.*)>/,1]

          # ignore link headers without rel
          if section[1] =~ /rel=/
            rel = section[1][/rel="*(.*)"*/,1].gsub(/"$/, "")
            rel.split.each do |name|

              unless base_url.blank?
                uri      = URI.parse(base_url)
                path     = url.gsub(%r{^/*}, "")
                uri.path = "/" + path
                url      = uri.normalize
              end

              links[name] = url
            end
          end
        end
      end

      links
    end

  end
end
