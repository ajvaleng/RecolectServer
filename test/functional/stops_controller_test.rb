require 'test_helper'

class StopsControllerTest < ActionController::TestCase
  setup do
    @stop = stops(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stop" do
    assert_difference('Stop.count') do
      post :create, stop: { stopdcode: @stop.stopdcode, stopid: @stop.stopid, stoplat: @stop.stoplat, stoplon: @stop.stoplon, stopname: @stop.stopname }
    end

    assert_redirected_to stop_path(assigns(:stop))
  end

  test "should show stop" do
    get :show, id: @stop
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stop
    assert_response :success
  end

  test "should update stop" do
    put :update, id: @stop, stop: { stopdcode: @stop.stopdcode, stopid: @stop.stopid, stoplat: @stop.stoplat, stoplon: @stop.stoplon, stopname: @stop.stopname }
    assert_redirected_to stop_path(assigns(:stop))
  end

  test "should destroy stop" do
    assert_difference('Stop.count', -1) do
      delete :destroy, id: @stop
    end

    assert_redirected_to stops_path
  end
end
