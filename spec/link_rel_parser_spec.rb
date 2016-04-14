require "spec_helper"

describe LinkRelParser do
  it "has a version number" do
    expect(LinkRelParser::VERSION).not_to be nil
  end

  describe ".parse" do
    it "returns an empty hash when there are no rel links" do
      expect(LinkRelParser.parse("http://example.org/")).to be {}
    end

    it "returns a hash with status, type, rels keys when rel links are found (from Aaron Parecki site)" do
      response = LinkRelParser.parse("http://aaronparecki.com/")

      expect(response[:status]).to eq 200
      expect(response[:type]).to   eq "text/html; charset=UTF-8"

      {
        "authorization_endpoint" => "https://aaronparecki.com/auth",
        "hub"                    => "https://switchboard.p3k.io/",
        "micropub"               => "https://aaronparecki.com/micropub",
        "self"                   => "https://aaronparecki.com/",
        "token_endpoint"         => "https://aaronparecki.com/auth/token",
      }.each do |name, url|
        expect(response[:rels][name]).to eq url
      end

    end

    it "works on ma.tt" do
      response = LinkRelParser.parse("http://ma.tt")

      expect(response[:status]).to_not be nil
      expect(response[:type]).to_not   be nil
      expect(response[:rels]).to_not   be nil
    end
  end

  describe ".link_rels" do
    it "returns an empty hash when there are no rel links" do
      expect(LinkRelParser.link_rels(nil)).to be {}
    end

    it "parses simple example" do
      headers   = %q{<http://example.org/>; rel=f}
      link_rels = {
        "f" => "http://example.org/"
      }

      expect(LinkRelParser.link_rels(headers)).to eq(link_rels)
    end

    it "parses link with two rels" do
      headers   = %q{<http://example.org/query?a=b,c>; rel="d e"}
      link_rels = {
        "d" => "http://example.org/query?a=b,c",
        "e" => "http://example.org/query?a=b,c"
      }

      expect(LinkRelParser.link_rels(headers)).to eq(link_rels)
    end

    it "parses simple example and example with two rels" do
      headers   = %q{<http://example.org/>; rel=f, <http://example.org/query?a=b,c>; rel="d e"}
      link_rels = {
        "d" => "http://example.org/query?a=b,c",
        "e" => "http://example.org/query?a=b,c",
        "f" => "http://example.org/"
      }

      expect(LinkRelParser.link_rels(headers)).to eq(link_rels)
    end

    it "parses multiple attributes" do
      headers   = %q{<http://example.org/>; rel="foo"; title="Example"}
      link_rels = { "foo" => "http://example.org/" }

      expect(LinkRelParser.link_rels(headers)).to eq(link_rels)
    end

    it "parses unusual case link header" do
      headers   = %q{<http://example.org/>; rel="foo"; title="Example"}
      link_rels = { "foo" => "http://example.org/" }

      expect(LinkRelParser.link_rels(headers)).to eq(link_rels)
    end

    it "parses link with no rel value" do
      headers   = %q{<http://example.org/>; title="Example"}
      link_rels = {}

      expect(LinkRelParser.link_rels(headers)).to eq(link_rels)
    end
  end

end
