require 'test_helper'

class TableSeatingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get table_seatings_show_url
    assert_response :success
  end

end
