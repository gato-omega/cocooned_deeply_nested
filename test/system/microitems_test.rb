require "application_system_test_case"

class MicroitemsTest < ApplicationSystemTestCase
  setup do
    @microitem = microitems(:one)
  end

  test "visiting the index" do
    visit microitems_url
    assert_selector "h1", text: "Microitems"
  end

  test "should create microitem" do
    visit microitems_url
    click_on "New microitem"

    fill_in "Name", with: @microitem.name
    fill_in "Subitem", with: @microitem.subitem_id
    click_on "Create Microitem"

    assert_text "Microitem was successfully created"
    click_on "Back"
  end

  test "should update Microitem" do
    visit microitem_url(@microitem)
    click_on "Edit this microitem", match: :first

    fill_in "Name", with: @microitem.name
    fill_in "Subitem", with: @microitem.subitem_id
    click_on "Update Microitem"

    assert_text "Microitem was successfully updated"
    click_on "Back"
  end

  test "should destroy Microitem" do
    visit microitem_url(@microitem)
    click_on "Destroy this microitem", match: :first

    assert_text "Microitem was successfully destroyed"
  end
end
