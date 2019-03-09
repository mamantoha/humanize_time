require "./spec_helper"

describe HumanizeTime do
  describe "distance_of_time_in_words" do
    test_data = [
      {from: 1.seconds.ago, to: Time.now, result: "less than a minute"},
      {from: 59.seconds.ago, to: Time.now, result: "less than a minute"},
      {from: 61.seconds.ago, to: Time.now, result: "1 minute"},
      {from: 5.minutes.ago, to: Time.now, result: "5 minutes"},
      {from: 30.minutes.ago, to: Time.now, result: "30 minutes"},
      {from: 59.minutes.ago, to: Time.now, result: "about 1 hour"},
      {from: 100.minutes.ago, to: Time.now, result: "about 1 hour"},
      {from: 2.hours.ago, to: Time.now, result: "about 2 hours"},
      {from: 25.hours.ago, to: Time.now, result: "1 day"},
      {from: 14.days.ago, to: Time.now, result: "14 days"},
      {from: 45.days.ago, to: Time.now, result: "about 1 month"},
      {from: 150.days.ago, to: Time.now, result: "5 months"},
      {from: 13.months.ago, to: Time.now, result: "about 1 year"},
      {from: 23.months.ago, to: Time.now, result: "almost 2 years"},
      {from: 80.months.ago, to: Time.now, result: "over 6 years"},
    ]

    test_data.each do |data|
      it "from #{data[:from]} to #{data[:to]} should match #{data[:result]}" do
        HumanizeTime.distance_of_time_in_words(data[:from], data[:to]).should eq(data[:result])
      end
    end
  end

  describe "distance_of_time_in_words with include_seconds" do
    test_data = [
      {from: 1.seconds.ago, to: Time.now, result: "less than 5 seconds"},
      {from: 3.seconds.ago, to: Time.now, result: "less than 5 seconds"},
      {from: 6.seconds.ago, to: Time.now, result: "less than 10 seconds"},
      {from: 25.seconds.ago, to: Time.now, result: "half a minute"},
      {from: 55.seconds.ago, to: Time.now, result: "less than a minute"},
      {from: 59.seconds.ago, to: Time.now, result: "1 minute"},
    ]

    test_data.each do |data|
      it "from #{data[:from]} to #{data[:to]} should match #{data[:result]}" do
        HumanizeTime.distance_of_time_in_words(data[:from], data[:to], include_seconds: true).should eq(data[:result])
      end
    end
  end
end
