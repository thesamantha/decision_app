require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path     #just make sure the signup form renders correctly
    assert_no_difference 'User.count' do    #before and after the 'do', there should be no difference in 'User.count'
      post users_path, user: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'   #page should render anew after an invalid signup attempt!
  end

  test "valid signup information" do
    get signup_path                     #make sure form renders correctly (test works without this)
    assert_difference 'User.count', 1 do    #assert that User.count differs by 1 after the following block
      post_via_redirect users_path, #arranges to follow redirect after submision
                                            user: { name: "Example User",
                                            email: "user@example.com",    #postin' all this stuff
                                            password:             "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'    #ensure user's show template renders following successful signup. For this to work, the Users routes, Users show action,and show.html.erb view need to work correctly.
  end
end
