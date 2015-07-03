require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get inbox" do
    get :inbox
    assert_response :success
  end

  test "should get outbox" do
    get :outbox
    assert_response :success
  end

  test "should get deleted" do
    get :deleted
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get view" do
    get :view
    assert_response :success
  end

end
