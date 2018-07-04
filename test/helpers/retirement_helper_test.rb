require 'test_helper'

class RetirementHelperTest < ActionView::TestCase

  test 'retirement helper calculates time distances from the current time to Year, Month, and Day' do
    assert_equal '1 day', time_difference_from_now(1.day.from_now)
    assert_equal '11 months and 30 days', time_difference_from_now(1.year.from_now)
    assert_equal '1 month and 29 days', time_difference_from_now(60.days.from_now)
    assert_equal '4 years, 4 months, and 26 days', time_difference_from_now(2317266.minutes.from_now)
    assert_equal '', time_difference_from_now(1.minute.from_now)
    assert_equal '1 day', time_difference_from_now(1.day.ago)
    assert_equal '11 months and 30 days', time_difference_from_now(1.year.ago)
    assert_equal '1 month and 29 days', time_difference_from_now(60.days.ago)
    assert_equal '4 years, 4 months, and 26 days', time_difference_from_now(2317266.minutes.ago)
    assert_equal '', time_difference_from_now(1.minute.ago)
  end

  test 'retirement helper calculates time distance score in Y-M-D format' do
    assert_equal '0-0-1', time_difference_from_now(1.day.from_now, :score)
    assert_equal '0-11-30', time_difference_from_now(1.year.from_now, :score)
    assert_equal '0-1-29', time_difference_from_now(60.days.from_now, :score)
    assert_equal '4-4-26', time_difference_from_now(2317266.minutes.from_now, :score)
    assert_equal '0-0-0', time_difference_from_now(1.minute.from_now, :score)
    assert_equal '0-0-1', time_difference_from_now(1.day.ago, :score)
    assert_equal '0-11-30', time_difference_from_now(1.year.ago, :score)
    assert_equal '0-1-29', time_difference_from_now(60.days.ago, :score)
    assert_equal '4-4-26', time_difference_from_now(2317266.minutes.ago, :score)
    assert_equal '0-0-0', time_difference_from_now(1.minute.ago, :score)
  end


end
