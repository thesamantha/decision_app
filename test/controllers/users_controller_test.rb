require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  base_title = "Decision App"

  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Sign up | " + base_title
  end

end
