# humanize_time

[![Crystal CI](https://github.com/mamantoha/humanize_time/actions/workflows/crystal.yml/badge.svg)](https://github.com/mamantoha/humanize_time/actions/workflows/crystal.yml)
[![GitHub release](https://img.shields.io/github/release/mamantoha/humanize_time.svg)](https://github.com/mamantoha/humanize_time/releases)
[![Commits Since Last Release](https://img.shields.io/github/commits-since/mamantoha/humanize_time/latest.svg)](https://github.com/mamantoha/humanize_time/pulse)
[![License](https://img.shields.io/github/license/mamantoha/humanize_time.svg)](https://github.com/mamantoha/humanize_time/blob/master/LICENSE)

Reports the approximate distance in time between two `Time` objects.
Pass `include_seconds: true` if you want more detailed approximations when distance < 1 min, 29 secs.

`humanize_time` supports `i18n` translations too so it can be used in internationalized apps.

`humanize_time` implementation is heavily inspired by (read: stolen) [distance_of_time_in_words](http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html#method-i-distance_of_time_in_words) method.
Many thanks to Rails community!

Distances are reported based on the following table:

| Value | Result |
| --- | --- |
| 0 <-> 29 secs                                                             | less than a minute   |
| 30 secs <-> 1 min, 29 secs                                                | 1 minute             |
| 1 min, 30 secs <-> 44 mins, 29 secs                                       | [2..44] minutes      |
| 44 mins, 30 secs <-> 89 mins, 29 secs                                     | about 1 hour         |
| 89 mins, 30 secs <-> 23 hrs, 59 mins, 29 secs                             | about [2..24] hours  |
| 23 hrs, 59 mins, 30 secs <-> 41 hrs, 59 mins, 29 secs                     | 1 day                |
| 41 hrs, 59 mins, 30 secs  <-> 29 days, 23 hrs, 59 mins, 29 secs           | [2..29] days         |
| 29 days, 23 hrs, 59 mins, 30 secs <-> 44 days, 23 hrs, 59 mins, 29 secs   | about 1 month        |
| 44 days, 23 hrs, 59 mins, 30 secs <-> 59 days, 23 hrs, 59 mins, 29 secs   | about 2 months       |
| 59 days, 23 hrs, 59 mins, 30 secs <-> 1 yr minus 1 sec                    | [2..12] months       |
| 1 yr <-> 1 yr, 3 months                                                   | about 1 year         |
| 1 yr, 3 months <-> 1 yr, 9 months                                         | over 1 year          |
| 1 yr, 9 months <-> 2 yr minus 1 sec                                       | almost 2 years       |
| 2 yrs <-> max time or date                                                | (same rules as 1 yr) |

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

HumanizeTime.locale = "es" # or `I18n.locale = "es"`

HumanizeTime.distance_of_time_in_words(42.minutes.ago, Time.local)
# => 42 minutos
HumanizeTime.distance_of_time_in_words(3.seconds.ago, Time.local, include_seconds: true)
# => menos de 5 segundos
```

## Available locales

Locale data synced with [rails-i18n](https://github.com/svenfuchs/rails-i18n) repository from files found in [rails/locale](http://github.com/svenfuchs/rails-i18n/tree/master/rails/locale/) directory.

Available 121 locales:

> ["af", "ar", "az", "be", "bg", "bn", "bs", "ca", "cs", "cy", "da", "de", "de-AT", "de-CH", "de-DE", "dz", "el", "el-CY", "en", "en-AU", "en-CA", "en-CY", "en-GB", "en-IE", "en-IN", "en-NZ", "en-TT", "en-US", "en-ZA", "eo", "es", "es-419", "es-AR", "es-CL", "es-CO", "es-CR", "es-EC", "es-ES", "es-MX", "es-NI", "es-PA", "es-PE", "es-US", "es-VE", "et", "eu", "fa", "fi", "fr", "fr-CA", "fr-CH", "fr-FR", "fy", "gd", "gl", "he", "hi", "hi-IN", "hr", "hu", "id", "is", "it", "it-CH", "ja", "ka", "kk", "km", "kn", "ko", "lb", "lo", "lt", "lv", "mg", "mk", "ml", "mn", "mr-IN", "ms", "nb", "ne", "nl", "nn", "oc", "or", "pa", "pap-AW", "pap-CW", "pl", "pt", "pt-BR", "rm", "ro", "ru", "sc", "sk", "sl", "sq", "sr", "st", "sv", "sv-FI", "sv-SE", "sw", "ta", "te", "th", "tl", "tr", "tt", "ug", "uk", "ur", "uz", "vi", "wo", "zh-CN", "zh-HK", "zh-TW", "zh-YUE"]

To re-sync locales run:

```console
crystal tool/sync_locales.cr
```

## Contributing

1. Fork it (<https://github.com/mamantoha/humanize_time/fork>)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mamantoha](https://github.com/mamantoha) Anton Maminov - creator, maintainer

## Special thanks

- [rails-i18n](https://github.com/svenfuchs/rails-i18n) community - Locale data
- [Morgan Aubert](https://github.com/ellmetha) - creator and maintainer of [i18n](https://github.com/crystal-i18n/i18n) an internationalization library for Crystal
