require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get create_account" do
    get :create_account
    assert_response :success
  end

  test "should get uzytkownicy" do
    get :uzytkownicy
    assert_response :success
  end

  test "should get profil" do
    get :profil
    assert_response :success
  end

end
