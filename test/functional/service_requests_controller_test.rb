require 'test_helper'

class ServiceRequestsControllerTest < ActionController::TestCase
  def setup
    @request    = ActionController::TestRequest.new
    login_as('quentin')
  end
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:service_requests)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_service_request
    assert_difference('ServiceRequest.count') do
      post :create, :service_request => { :record_number => 'service123' }
    end

    assert_redirected_to service_request_path(assigns(:service_request))
  end

  def test_should_show_service_request
    get :show, :id => incidents(:service).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => incidents(:service).id
    assert_response :success
  end

  def test_should_update_service_request
    put :update, :id => incidents(:service).id, :service_request => { }
    assert_redirected_to service_request_path(assigns(:service_request))
  end

  def test_should_destroy_service_request
    assert_difference('ServiceRequest.count', -1) do
      delete :destroy, :id => incidents(:service).id
    end

    assert_redirected_to service_requests_path
  end
end
