# humanize_time

![Crystal CI](https://github.com/mamantoha/humanize_time/workflows/Crystal%20CI/badge.svg?branch=master)
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

Available locales:

> ["de-CH", "ml", "nl", "fr-CH", "ka", "sq", "id", "ur", "es-CO", "en", "es-US", "bn", "gl", "de-DE", "ms", "is", "hr", "ca", "lv", "zh-TW", "en-TT", "cy", "az", "en-GB", "el", "cs", "he", "en-CA", "es-NI", "tl", "sw", "wo", "es", "sr", "el-CY", "es-419", "fr-FR", "mr-IN", "uz", "sl", "es-AR", "sk", "ug", "zh-CN", "it-CH", "zh-YUE", "kn", "et", "en-CY", "en-AU", "nb", "it", "mn", "fr", "bg", "nn", "tt", "ko", "eo", "km", "hu", "da", "bs", "de-AT", "pap-CW", "pl", "es-MX", "mk", "sv-SE", "pap-AW", "af", "es-CL", "ja", "es-PE", "eu", "es-PA", "be", "pt", "st", "ru", "kk", "fy", "uk", "fa", "ta", "hi-IN", "zh-HK", "en-US", "pt-BR", "or", "en-ZA", "es-ES", "en-IN", "es-EC", "de", "ne", "mg", "vi", "lo", "lt", "rm", "hi", "th", "fr-CA", "oc", "fi", "ar", "es-CR", "en-NZ", "pa", "sv", "lb", "en-IE", "ro", "tr", "es-VE", "te"]

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
