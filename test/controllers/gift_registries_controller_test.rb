require 'test_helper'

class GiftRegistriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gift_registries_show_url
    assert_response :success
  end

end
