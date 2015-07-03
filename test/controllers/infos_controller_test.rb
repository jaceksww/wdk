require 'test_helper'

class InfosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get latest" do
    get :latest
    assert_response :success
  end

end
