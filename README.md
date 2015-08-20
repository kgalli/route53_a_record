# Route53ARecord

Create, update or delete route53 A records.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'route53_a_record'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install route53_a_record

## Usage

### Create, Update, or Delete an A Record

```ruby
require 'route53_a_record'

# aws credentials
aws_region = 'eu-central1'
aws_access_key_id = 'AKIAIOSFODNN7EXAMPLE'
aws_secret_access_key = 'wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'

# aws hosted zone and a like properties
aws_hosted_zone = 'K5NPEL7EXAMPLE'
aws_hosted_zone_a_entry = '10.1.1.1'
aws_hosted_zone_domain = 'route53.example.com'

# The Route53ARecord::Record is used to cescribe the record you want
# to create, update or delete. The last parameter is the `ttl` which defaults
# to `15` (seconds) if not specified.
record = Route53ARecord::Record.new(aws_hosted_zone, aws_hosted_zone_domain, aws_hosted_zone_a_entry, 30)

# The `Route53ARecord::Handler` is used to perform the creation or
# update if the given `Route53ARecord::Record`. It provides a
# parameter overwrite which has to be used for updates. If it is
# set to `false` updates will raise an exception. The default is `true`.
handler = Route53ARecord::Handler.new(aws_region, aws_access_key_id, aws_secret_access_key, true)

# to create the A record
handler.create(record)


# to delete the A record
handler.delete(record)
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/route53_a_record/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
