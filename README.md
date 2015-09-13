# LogScroll

[![Gem Version](https://badge.fury.io/rb/log_scroll.svg)](http://badge.fury.io/rb/log_scroll) [![Build Status](https://travis-ci.org/presidentJFK/log_scroll.svg?branch=master)](https://travis-ci.org/presidentJFK/log_scroll) [![Test Coverage](https://codeclimate.com/github/presidentJFK/log_scroll/badges/coverage.svg)](https://codeclimate.com/github/presidentJFK/log_scroll/coverage) [![Code Climate](https://codeclimate.com/github/presidentJFK/log_scroll/badges/gpa.svg)](https://codeclimate.com/github/presidentJFK/log_scroll) [![Dependency Status](https://gemnasium.com/presidentJFK/log_scroll.svg)](https://gemnasium.com/presidentJFK/log_scroll) [![Inline docs](http://inch-ci.org/github/presidentJFK/log_scroll.svg?branch=master)](http://inch-ci.org/github/presidentJFK/log_scroll)

### \*\*WARNING THIS GEM IS PRE 1.0 AND STILL UNSTABLE\*\*

A simple gem for creating a rolling log files

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'log_scroll'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install log_scroll

## Usage

Proposed API:

```ruby
scroll = LogScroll.new(max_size: 10, file_name: "history.log")
scroll.log("first log entry")
scroll.log("second log entry")

scroll.entries
# => ["first log entry\n", "second log entry\n"]

puts "Oldest Entry: " + scroll.oldest_entry
# => "Oldest Entry: first log entry"

puts "Newest Entry: " + scroll.newest_entry
# => "Newest Entry: second log entry"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/log_scroll/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
