[![Build Status](https://travis-ci.org/khrystynaklochko/smart_money.svg)](https://travis-ci.org/khrystynaklochko/smart_money)
[![Coverage Status](https://coveralls.io/repos/khrystynaklochko/smart_money/badge.svg?branch=master&service=github)](https://coveralls.io/github/khrystynaklochko/smart_money?branch=master)
# SmartMoney

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/smart_money`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smart_money'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smart_money

## Usage
This gem:
# Can create money objects for different currencies :
ten_euros = Money.new(10,'EURO')


# Can get amount and currency:

ten_euros.amount   # => 10
ten_euros.currency # => "EUR"
ten_euros.inspect  # => "50.00 EUR"

# Can configure the currency rates with respect to a base currency (here USD):

Money.conversion_rates('USD', {
  'EURO'     => 0.89,
  'Bitcoin' => 0.0034
})
# Can onvert to a different currency(return instance)
ten_euros.convert_to("USD") # => 11.1 USD

#Provide different operations

# Arithmetics:

ten_euros + ten_dollars # => 1.11 EUR
ten_euros / 2              # => 5.55 EUR
ten_euros * 3         # => 3.33 EUR

# Comparisons (also in different currencies):

ten_dollars == Money.new(10, 'USD') # => true
ten_euros == Money.new(10, 'EUR') # => false

ten_eur_in_usd = ten_euros.convert_to('USD')
ten_euros_in_usd == ten_euros         # => true

ten_dollars < ten_euros              # => true

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/smart_money. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

