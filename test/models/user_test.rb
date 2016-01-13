require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should be short enough" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be short enough" do
    @user.email  = "a" * 256
    assert_not @user.valid?
  end

  test "should accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]  #all legit emails so shouldn't turn up any errors
    valid_addresses.each do |valid_address|   #iterate through valid_addresses
      @user.email = valid_address           #assign each address to @user to test @user's validity
      assert @user.valid?, "#{valid_address.inspect} should be valid"   #if assert returns false, print faulty address + " should be valid"
    end
  end

  test "should reject invalid email addresses" do     #same deal as above, but email addies are invalid and we're asserting_not
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "password should be present (not blank)" do
    @user.password = @user.password_confirmation = " " * 6    #password has to be at least 6 chars; need to fail validation for the right reason here
    assert_not @user.valid?     #i.e. here, we should assert that the user is invalid because its password is blank, not because its password wasn't long enough
  end

  test "password should be long enough" do
    @user.password = @user.password_confirmation = "a" * 5    #again, need to fail validation for right reason here: use some character instead of blank space
    assert_not @user.valid?
  end

end
