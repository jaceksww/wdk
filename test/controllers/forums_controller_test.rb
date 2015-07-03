require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get viewforum" do
    get :viewforum
    assert_response :success
  end

  test "should get viewtopic" do
    get :viewtopic
    assert_response :success
  end

  test "should get addtopic" do
    get :addtopic
    assert_response :success
  end

  test "should get addreply" do
    get :addreply
    assert_response :success
  end

  test "should get subscribe" do
    get :subscribe
    assert_response :success
  end

end
