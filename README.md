# LinkRelParser (Ruby)

Parse HTTP `Link` headers into a structured format


## Version

0.1.1

![Version 0.1.1](https://img.shields.io/badge/VERSION-0.1.1-green.svg)


## Code Status

[![Build Status](https://travis-ci.org/indieweb/link_rel_parser-ruby.svg?branch=master)](https://travis-ci.org/indieweb/link_rel_parser-ruby)
[![Code Climate](https://codeclimate.com/github/indieweb/link_rel_parser-ruby/badges/gpa.svg)](https://codeclimate.com/github/indieweb/link_rel_parser-ruby)


## Installation

Add this line to your application's Gemfile:

```ruby
gem "link_rel_parser"
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install link_rel_parser
```


## Usage

```ruby
require "link_rel_parser"
LinkRelParser.parse("https://aaronparecki.com")

{
  "authorization_endpoint" => "https://aaronparecki.com/auth",
  "hub"                    => "https://switchboard.p3k.io/",
  "micropub"               => "https://aaronparecki.com/micropub",
  "self"                   => "https://aaronparecki.com/",
  "token_endpoint"         => "https://aaronparecki.com/auth/token"
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec link_rel_parser` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Authors

* Shane Becker / [@veganstraightedge](https://github.com/veganstraightedge)


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/indieweb/link_rel_parser-ruby/issues. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it
2. Get it running (see Installation above)
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Write your code and **specs**
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/indieweb/link_rel_parser-ruby/issues).


## Code of Conduct

Everyone interacting in the LinkRelParser (Ruby) codebase, issue tracker, chat room, and mailing lists is expected to follow the
[LinkRelParser (Ruby) code of conduct](https://github.com/indieweb/link_rel_parser-ruby/blob/master/CODE_OF_CONDUCT.md).


## License

**PUBLIC DOMAIN**

Your heart is as free as the air you breathe. <br>
The ground you stand on is liberated territory.

In legal text, LinkRelParser (Ruby) is dedicated to the public domain
using Creative Commons -- CC0 1.0 Universal.

[http://creativecommons.org/publicdomain/zero/1.0](http://creativecommons.org/publicdomain/zero/1.0 "Creative Commons &mdash; CC0 1.0 Universal")
