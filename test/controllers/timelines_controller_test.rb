require 'test_helper'

class TimelinesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get timelines_show_url
    assert_response :success
  end

end
