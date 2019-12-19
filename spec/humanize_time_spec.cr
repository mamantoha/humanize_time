require "./spec_helper"

describe HumanizeTime do
  context "with I18n.locale" do
    before_each { I18n.locale = "uk" }

    it "should translate" do
      HumanizeTime.distance_of_time_in_words(80.months.ago, Time.local).should eq("більше 6 років")
    end

    after_each { I18n.locale = nil }
  end

  context "I18n.with_locale" do
    it "should translate" do
      (
        I18n.with_locale("uk") do
          HumanizeTime.distance_of_time_in_words(80.months.ago, Time.local)
        end
      ).should eq("більше 6 років")
    end
  end

  context "with English locale" do
    describe "distance_of_time_in_words" do
      test_data = [
        {from: 1.seconds.ago, to: Time.local, result: "less than a minute"},
        {from: 59.seconds.ago, to: Time.local, result: "less than a minute"},
        {from: 61.seconds.ago, to: Time.local, result: "1 minute"},
        {from: 5.minutes.ago, to: Time.local, result: "5 minutes"},
        {from: 30.minutes.ago, to: Time.local, result: "30 minutes"},
        {from: 59.minutes.ago, to: Time.local, result: "about 1 hour"},
        {from: 100.minutes.ago, to: Time.local, result: "about 1 hour"},
        {from: 2.hours.ago, to: Time.local, result: "about 2 hours"},
        {from: 25.hours.ago, to: Time.local, result: "1 day"},
        {from: 14.days.ago, to: Time.local, result: "14 days"},
        {from: 45.days.ago, to: Time.local, result: "about 1 month"},
        {from: 150.days.ago, to: Time.local, result: "5 months"},
        {from: 13.months.ago, to: Time.local, result: "about 1 year"},
        {from: 23.months.ago, to: Time.local, result: "almost 2 years"},
        {from: 80.months.ago, to: Time.local, result: "over 6 years"},
      ]

      test_data.each do |data|
        it "from #{data[:from]} to #{data[:to]} should match #{data[:result]}" do
          HumanizeTime.distance_of_time_in_words(data[:from], data[:to]).should eq(data[:result])
        end
      end
    end

    describe "distance_of_time_in_words with include_seconds" do
      test_data = [
        {from: 1.seconds.ago, to: Time.local, result: "less than 5 seconds"},
        {from: 3.seconds.ago, to: Time.local, result: "less than 5 seconds"},
        {from: 6.seconds.ago, to: Time.local, result: "less than 10 seconds"},
        {from: 25.seconds.ago, to: Time.local, result: "half a minute"},
        {from: 55.seconds.ago, to: Time.local, result: "less than a minute"},
        {from: 59.seconds.ago, to: Time.local, result: "1 minute"},
      ]

      test_data.each do |data|
        it "from #{data[:from]} to #{data[:to]} should match #{data[:result]}" do
          HumanizeTime.distance_of_time_in_words(data[:from], data[:to], include_seconds: true).should eq(data[:result])
        end
      end
    end

    describe "distance_of_time_in_words with Time::Span" do
      it "should accept Time::Span" do
        HumanizeTime.distance_of_time_in_words(1.second, include_seconds: true).should eq("less than 5 seconds")
      end
    end
  end

  context "with Ukrainian locale" do
    before_each do
      HumanizeTime.locale = "uk"
    end

    after_each do
      HumanizeTime.locale = "en"
    end

    describe "distance_of_time_in_words" do
      test_data = [
        {from: 1.seconds.ago, to: Time.local, result: "менше 1 хвилини"},
        {from: 59.seconds.ago, to: Time.local, result: "менше 1 хвилини"},
        {from: 61.seconds.ago, to: Time.local, result: "1 хвилина"},
        {from: 5.minutes.ago, to: Time.local, result: "5 хвилин"},
        {from: 30.minutes.ago, to: Time.local, result: "30 хвилин"},
        {from: 59.minutes.ago, to: Time.local, result: "близько 1 години"},
        {from: 100.minutes.ago, to: Time.local, result: "близько 1 години"},
        {from: 2.hours.ago, to: Time.local, result: "близько 2 годин"},
        {from: 25.hours.ago, to: Time.local, result: "1 день"},
        {from: 14.days.ago, to: Time.local, result: "14 днів"},
        {from: 45.days.ago, to: Time.local, result: "близько 1 місяця"},
        {from: 150.days.ago, to: Time.local, result: "5 місяців"},
        {from: 13.months.ago, to: Time.local, result: "близько 1 року"},
        {from: 23.months.ago, to: Time.local, result: "майже 2 роки"},
        {from: 80.months.ago, to: Time.local, result: "більше 6 років"},
      ]

      test_data.each do |data|
        it "from #{data[:from]} to #{data[:to]} should match #{data[:result]}" do
          HumanizeTime.distance_of_time_in_words(data[:from], data[:to]).should eq(data[:result])
        end
      end
    end

    describe "distance_of_time_in_words with include_seconds" do
      test_data = [
        {from: 1.seconds.ago, to: Time.local, result: "менше 5 секунд"},
        {from: 3.seconds.ago, to: Time.local, result: "менше 5 секунд"},
        {from: 6.seconds.ago, to: Time.local, result: "менше 10 секунд"},
        {from: 25.seconds.ago, to: Time.local, result: "пів хвилини"},
        {from: 55.seconds.ago, to: Time.local, result: "менше 1 хвилини"},
        {from: 59.seconds.ago, to: Time.local, result: "1 хвилина"},
      ]

      test_data.each do |data|
        it "from #{data[:from]} to #{data[:to]} should match #{data[:result]}" do
          HumanizeTime.distance_of_time_in_words(data[:from], data[:to], include_seconds: true).should eq(data[:result])
        end
      end
    end
  end
end
