require 'test_helper'

class WsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get galerie" do
    get :galerie
    assert_response :success
  end

end
