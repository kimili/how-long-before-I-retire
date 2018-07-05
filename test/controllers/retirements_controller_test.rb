require 'test_helper'

class RetirementsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get retirements_new_url
    assert_response :success
  end

  test "should get show" do
    get retirements_show_url
    assert_response :success
  end

end
