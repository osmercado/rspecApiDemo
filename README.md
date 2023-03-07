# RSpecs + Rails + API calls tests

This demo aims to demostrate the testing for API calls using RSpecs in Rails.

* Ruby version
ruby 3.2.1

* Rails version
rails 7.0.4.2

## How to setup RSpec

Version:
rspec (3.12.0)

- add 'rspec-rails' gem to the Gemfile
```
gem 'rspec-rails'
```

- To set up RSPEC run:
```
$ rspec:install
```

- Run tests
```
$ rspec
```

- Run specific test file
```
$ rspec /spec/..{filename}_spec.rb
```

- ./spec/requests/user_api_spec.rb is file that contains the rspec tests

## HTTPParty
For this porpuse demo, we are using HTTPParty to perform API calls dureing tests. HTTPParty gem aid us handle reqres's (https://reqres.in) api request
```
gem 'httparty'
```

Version:
httparty (0.21.0)

