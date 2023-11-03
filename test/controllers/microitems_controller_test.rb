require "test_helper"

class MicroitemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @microitem = microitems(:one)
  end

  test "should get index" do
    get microitems_url
    assert_response :success
  end

  test "should get new" do
    get new_microitem_url
    assert_response :success
  end

  test "should create microitem" do
    assert_difference("Microitem.count") do
      post microitems_url, params: { microitem: { name: @microitem.name, subitem_id: @microitem.subitem_id } }
    end

    assert_redirected_to microitem_url(Microitem.last)
  end

  test "should show microitem" do
    get microitem_url(@microitem)
    assert_response :success
  end

  test "should get edit" do
    get edit_microitem_url(@microitem)
    assert_response :success
  end

  test "should update microitem" do
    patch microitem_url(@microitem), params: { microitem: { name: @microitem.name, subitem_id: @microitem.subitem_id } }
    assert_redirected_to microitem_url(@microitem)
  end

  test "should destroy microitem" do
    assert_difference("Microitem.count", -1) do
      delete microitem_url(@microitem)
    end

    assert_redirected_to microitems_url
  end
end
