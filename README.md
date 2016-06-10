# Bit Core Rails engine

This engine provides basic models and logic for slideshows.

## Version 2.0.x

Please note that version 2.0.x supports only Ruby 2.3.0 and Rails 5. If you need
support for Rails 4, please use the latest 1.x version.

## Dependencies

The host application will need to specify an Arm class 'app/models/arm.rb'

```ruby
# app/models/arm.rb
class Arm
  ...
end
```

## Running Specs

```console
bin/rake app:db:drop app:db:create app:db:migrate RAILS_ENV=test
bin/rake
```
