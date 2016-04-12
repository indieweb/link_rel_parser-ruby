require "spec_helper"

describe LinkRelParser do
  it "has a version number" do
    expect(LinkRelParser::VERSION).not_to be nil
  end

  describe ".parse" do
    it "returns an empty hash when there are no rel links" do
      expect(LinkRelParser.parse(nil)).to be {}
    end

    it "returns a hash with status, type, rels keys when rel links are found" do
      headers  = %q{Link: <http://example.org/>; rel="foo"; title="Example"}
      response = LinkRelParser.parse(headers)

      expect(response[:status]).to_not be nil
      expect(response[:type]).to_not   be nil
      expect(response[:rels]).to_not   be nil
    end
  end

  # describe ".rels" do
  #   it "parses simple example" do
  #     headers   = %q{Link: <http://example.org/query?a=b,c>; rel="d e", <http://example.org/>; rel=f}
  #     link_rels = [
  #       { "d": "http://example.org/query?a=b,c" },
  #       { "e": "http://example.org/query?a=b,c" },
  #       { "f": "http://example.org/" }
  #     ]
  #
  #     expect(LinkRelParser.rels(headers)).to eq(link_rels)
  #   end
  #
  #   it "parses multiple attributes" do
  #     headers   = %q{Link: <http://example.org/>; rel="foo"; title="Example"}
  #     link_rels = [ { "foo": "http://example.org/" } ]
  #
  #     expect(LinkRelParser.rels(headers)).to eq(link_rels)
  #   end
  #
  #   it "parses unusual case link header" do
  #     headers   = %q{LinK: <http://example.org/>; rel="foo"; title="Example"}
  #     link_rels = [ { "foo": "http://example.org/" } ]
  #
  #     expect(LinkRelParser.rels(headers)).to eq(link_rels)
  #   end
  #
  #   it "parses link with no rel value" do
  #     headers   = %q{Link: <http://example.org/>; title="Example"}
  #     link_rels = []
  #
  #     expect(LinkRelParser.rels(headers)).to eq(link_rels)
  #   end
  #
  #   it "parses links rels from Aaron Parecki site" do
  #     link_rels = [
  #       { "http://webmention.org/": "http://aaronparecki.com/webmention.php" },
  #       { "indieauth":              "https://indieauth.com" },
  #       { "pingback":               "http://pingback.me/webmention?forward=http%3A%2F%2Faaronparecki.com%2Fwebmention.php" }
  #     ]
  #
  #     headers = %q{
  #       HTTP/1.1 200 OK
  #       Server: nginx/1.0.14
  #       Date: Sat, 26 Oct 2013 01:40:11 GMT
  #       Content-Type: text/html; charset=UTF-8
  #       Connection: keep-alive
  #       Link: <https://indieauth.com>; rel="indieauth"
  #       X-Pingback: http://pingback.me/webmention?forward=http%3A%2F%2Faaronparecki.com%2Fwebmention.php
  #       Link: <http://aaronparecki.com/webmention.php>; rel="http://webmention.org/"
  #     }
  #
  #     expect(LinkRelParser.rels(headers)).to eq(link_rels)
  #   end
  #
  # end
end
