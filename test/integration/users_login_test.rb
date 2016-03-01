require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # want to make sure that upon logging in with invalid information, the new sessions form gets re-rendered with an accompanying flash message
  # then upon visiting another page, the flash message should *not* appear
  test "login with invalid information" do
    get login_path    # get us on the login path
    assert_template 'sessions/new'  # make sure the right page renders
    post login_path,  session: { email: "", password: ""}   # invalid login credentials
    assert_template 'sessions/new'  # should redirect
    assert_not flash.empty?   # flash should be there! (i.e. assert_NOT flash "empty")
    get root_path         # so let's head off somewhere else...
    assert flash.empty?     # now the flash should NOT be there!
  end
end
