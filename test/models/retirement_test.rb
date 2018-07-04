require 'test_helper'

class RetirementTest < ActiveSupport::TestCase

  def setup
    @still_working   = retirements :still_working
    @almost_there    = retirements :almost_there
    @already_retired = retirements :already_retired
  end

  test 'name should not be blank' do
    @still_working.name = 'working stiff'
    assert @still_working.valid?
    @still_working.name = ''
    assert_not @still_working.valid?
  end

  test 'name should not be too long' do
    @still_working.name = 'a' * 255
    assert @still_working.valid?
    @still_working.name = 'a' * 256
    assert_not @still_working.valid?
  end

  test 'name should accept emoji' do
    @still_working.name = "😈" * 255
    @still_working.save
    assert @still_working.valid?
  end

  test 'name should strip leading and trailing whitespace' do
    sloppy_name = " #{@still_working.name}   "
    @still_working.name = sloppy_name
    @still_working.save
    assert_equal sloppy_name.strip, @still_working.reload.name
  end

  test 'retirement date should be a valid date' do
    @still_working.retirement_date = 30.years.from_now.to_datetime
    assert @still_working.valid?
    @still_working.retirement_date = 'still so long?!?'
    assert_not @still_working.valid?
  end

  test 'retired? should return boolean, based on the retirement_date' do
    assert_not @still_working.retired?
    assert_not @almost_there.retired?
    assert @already_retired.retired?
  end

  test 'Arbitrary HTML should be stripped string attributes on save' do
    html = '<b><a href="http://foo.com/">foo</a></b><img src="bar.jpg"><script src="http://hackz.js"></script>'
    @still_working.attributes.each do |attr_name, attr_value|
      next unless attr_value.is_a? String
      @still_working[attr_name] = html
      if @still_working.valid?
        @still_working.save!
        assert_equal 'foo', @still_working.reload[attr_name]
      else
        # The HTML string didn't pass validation. Reset the value
        @still_working[attr_name] = attr_value
      end
    end
  end

end
