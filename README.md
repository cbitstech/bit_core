## Installation

In order to run migrations, you will need to create a 'schema.rb' file (it is in the .gitignore).
```console
  touch spec/dummy/db/schema.rb
```

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
  bin/rspec
```
