require "i18n"

require "./humanize_time/*"

I18n.load_path << File.join(__DIR__, "locales")
# Heroku fix
I18n.load_path << File.join(Dir.current, "lib/humanize_time/src/locales")

I18n.init

module HumanizeTime
  extend self

  MINUTES_IN_YEAR                = 525600
  MINUTES_IN_QUARTER_YEAR        = 131400
  MINUTES_IN_THREE_QUARTERS_YEAR = 394200

  # Inspired by http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html#method-i-distance_of_time_in_words
  def distance_of_time_in_words(from_time : Time, to_time : Time, include_seconds = false)
    distance = to_time - from_time

    distance_in_seconds = distance.total_seconds
    distance_in_minutes = distance.total_minutes

    case distance_in_minutes
    when 0...2
      if include_seconds
        case distance_in_seconds
        when 0...5
          t("less_than_x_seconds", count: 5)
        when 5...10
          t("less_than_x_seconds", count: 10)
        when 10..20
          t("less_than_x_seconds", count: 20)
        when 20...40
          t("half_a_minute")
        when 40...59
          t("less_than_x_minutes", count: 1)
        else
          t("x_minutes", count: 1)
        end
      else
        if distance_in_minutes.to_i.zero?
          return t("less_than_x_minutes", count: 1)
        else
          return t("x_minutes", count: distance_in_minutes.to_i)
        end
      end
    when 2...45
      t("x_minutes", count: distance_in_minutes.to_i)
    when 45...90
      t("about_x_hours", count: 1)
    when 90...1440 # 90 mins up to 24 hours
      t("about_x_hours", count: (distance_in_minutes / 60).to_i)
    when 1440...2520 # 24 hours up to 42 hours
      t("x_days", count: 1)
    when 2520...43200 # 42 hours up to 30 days
      t("x_days", count: (distance_in_minutes / 1440).to_i)
    when 43200...86400 # 30 days up to 60 days
      t("about_x_months", count: (distance_in_minutes / 43200).to_i)
    when 86400...525600 # 60 days up to 365 days
      t("x_months", count: (distance_in_minutes / 43200.0).to_i)
    else
      from_year = from_time.year
      from_year += 1 if from_time.month >= 3
      to_year = to_time.year
      to_year -= 1 if to_time.month < 3
      leap_years = (from_year > to_year) ? 0 : (from_year..to_year).count { |year| Time.leap_year?(year) }
      minute_offset_for_leap_year = leap_years * 1440
      # Discount the leap year days when calculating year distance.
      # e.g. if there are 20 leap year days between 2 dates having the same day
      # and month then the based on 365 days calculation
      # the distance in years will come out to over 80 years when in written
      # English it would read better as about 80 years.
      minutes_with_offset = distance_in_minutes - minute_offset_for_leap_year
      remainder = (minutes_with_offset % MINUTES_IN_YEAR)
      distance_in_years = (minutes_with_offset.fdiv(MINUTES_IN_YEAR))

      if remainder < MINUTES_IN_QUARTER_YEAR
        t("about_x_years", count: distance_in_years.to_i)
      elsif remainder < MINUTES_IN_THREE_QUARTERS_YEAR
        t("over_x_years", count: distance_in_years.to_i)
      else
        t("almost_x_years", count: (distance_in_years + 1).to_i)
      end
    end
  end

  private def t(key : String)
    I18n.translate("humanize_time.#{key}")
  end

  private def t(key : String, count : Int32)
    I18n.translate("humanize_time.#{key}", count: count)
  end
end
