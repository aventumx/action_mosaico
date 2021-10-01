# Action Mosaico

Action Mosaico brings rich email editing to Rails. It includes the [Mosaico](https://mosaico.io/) that handles everything from formatting to links to quotes to lists to embedded images and galleries. The rich text content generated by the Trix editor is saved in its own RichText model that's associated with any existing Active Record model in the application. Any embedded images (or other attachments) are automatically stored using Active Storage and associated with the included RichText model.

You can read more about Action Mosaico in the [Action Mosaico Overview](https://edgeguides.rubyonrails.org/action_text_overview.html) guide.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_mosaico'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install action_mosaico

## Usage

TODO: Write usage instructions here

## Development

The JavaScript for Action Mosaico is distributed both as a npm module under action_mosaico and via the asset pipeline as action_mosaico.js (and we mirror Mosaico as mosaico.js). To ensure that the latter remains in sync, you must run `yarn build` and checkin the artifacts whenever the JavaScript source or the Mosaico dependency is bumped.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aventumx/action_mosaico. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/aventumx/action_mosaico/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActionMosaico project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aventumx/action_mosaico/blob/main/CODE_OF_CONDUCT.md).
