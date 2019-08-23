require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "blank username" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "", email: "user@example.com", password: "foo", password_confirmation: "foo" } }
    end
    assert_template 'users/new'
  end

  test "blank email" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "Test", email: "user@", password: "foo", password_confirmation: "foo" } }
    end
    assert_template 'users/new'
  end

  test "blank password" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "Test", email: "user@example.com", password: "", password_confirmation: "foo" } }
    end
    assert_template 'users/new'
  end

  test "blank password confirmation" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "Test", email: "user@example.com", password: "foo", password_confirmation: "" } }
    end
    assert_template 'users/new'
  end

  test "password and password confirmation don't match" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "Test", email: "user@example.com", password: "foo", password_confirmation: "food" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User", email: "user@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
