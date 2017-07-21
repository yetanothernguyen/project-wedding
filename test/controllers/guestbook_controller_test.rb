require 'test_helper'

class GuestbookControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get guestbook_index_url
    assert_response :success
  end

end
