## Installation

Add this line to your application's Gemfile:

```ruby
gem 'headings', git: 'https://github.com/kongo555/headings'
```

And then execute:

    $ bundle

## Usage

```ruby
data = [
  { id: 1, title: 'heading1', heading_level: 0 },
  { id: 2, title: 'heading2', heading_level: 2 },
  { id: 3, title: 'heading3', heading_level: 1 },
  { id: 4, title: 'heading4', heading_level: 1 }
]
Headings::Generator.new(data).call  #=> "1. Heading1\n\t\t1.1.1. Heading2\n\t1.2. Heading3\n\t1.3. Heading4"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kongo555/headings.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
