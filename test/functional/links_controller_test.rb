require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  include AuthenticatedTestHelper
  fixtures :users

  test "should get index" do
    login_as :quentin
    get :index
    assert_response :success
    assert_not_nil assigns(:links)
  end

  test "should get new" do
    login_as :quentin
    get :new
    assert_response :success
  end

  test "should create link" do
    login_as :quentin
    assert_difference('Link.count') do
      post :create, :link => { :title => 'test' }
    end

    assert_redirected_to link_path(assigns(:link))
  end

  test "should show link" do
    login_as :quentin
    get :show, :id => links(:learningrails).to_param
    assert_response :success
  end

  test "should get edit" do
    login_as :quentin
    get :edit, :id => links(:learningrails).to_param
    assert_response :success
  end

  test "should update link" do
    login_as :quentin
    put :update, :id => links(:learningrails).to_param, :link => { }
    assert_redirected_to link_path(assigns(:link))
  end

  test "should destroy link" do
    login_as :quentin
    assert_difference('Link.count', -1) do
      delete :destroy, :id => links(:learningrails).to_param
    end

    assert_redirected_to links_path
  end

  def test_should_not_get_index_not_logged_in
    get :index
    assert_redirected_to new_session_path
  end
end
