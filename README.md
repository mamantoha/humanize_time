# humanize_time

[![Build Status](http://img.shields.io/travis/mamantoha/humanize_time.svg?style=flat)](https://travis-ci.org/mamantoha/humanize_time)
[![GitHub release](https://img.shields.io/github/release/mamantoha/humanize_time.svg)](https://github.com/mamantoha/humanize_time/releases)
[![Commits Since Last Release](https://img.shields.io/github/commits-since/mamantoha/humanize_time/latest.svg)](https://github.com/mamantoha/humanize_time/pulse)
[![License](https://img.shields.io/github/license/mamantoha/humanize_time.svg)](https://github.com/mamantoha/humanize_time/blob/master/LICENSE)

Reports the approximate distance in time between two `Time` objects.
Pass `include_seconds: true` if you want more detailed approximations when distance < 1 min, 29 secs.

`humanize_time` supports `i18n` translations too so it can be used in internationalized apps.

`humanize_time` is heavily inspired by (read: stolen) [distance_of_time_in_words](http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html#method-i-distance_of_time_in_words) method.
Thanks.

Distances are reported based on the following table:

```console
0 <-> 29 secs                                                             # => less than a minute
30 secs <-> 1 min, 29 secs                                                # => 1 minute
1 min, 30 secs <-> 44 mins, 29 secs                                       # => [2..44] minutes
44 mins, 30 secs <-> 89 mins, 29 secs                                     # => about 1 hour
89 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                             # => about [2..24] hours
23 hrs, 59 mins, 30 secs <-> 41 hrs, 59 mins, 29 secs                     # => 1 day
41 hrs, 59 mins, 30 secs  <-> 29 days, 23 hrs, 59 mins, 29 secs           # => [2..29] days
29 days, 23 hrs, 59 mins, 30 secs <-> 44 days, 23 hrs, 59 mins, 29 secs   # => about 1 month
44 days, 23 hrs, 59 mins, 30 secs <-> 59 days, 23 hrs, 59 mins, 29 secs   # => about 2 months
59 days, 23 hrs, 59 mins, 30 secs <-> 1 yr minus 1 sec                    # => [2..12] months
1 yr <-> 1 yr, 3 months                                                   # => about 1 year
1 yr, 3 months <-> 1 yr, 9 months                                         # => over 1 year
1 yr, 9 months <-> 2 yr minus 1 sec                                       # => almost 2 years
2 yrs <-> max time or date                                                # => (same rules as 1 yr)
```

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  humanize_time:
    github: mamantoha/humanize_time
```

## Usage

```crystal
require "humanize_time"

HumanizeTime.distance_of_time_in_words(42.minutes.ago, Time.now)
HumanizeTime.distance_of_time_in_words(3.seconds.ago, Time.now, include_seconds: true)
```

## Contributing

1. Fork it ( https://github.com/mamantoha/humanize_time/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mamantoha](https://github.com/mamantoha) Anton Maminov - creator, maintainer
