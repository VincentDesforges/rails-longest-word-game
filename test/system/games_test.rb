require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  # test "saying a correct word gives an increased score" do
  #   visit new_url
  #   puts "====================="
  #   p find_all('flex-content') # [0]['innerHTML']
  #   puts "====================="
  #   fill_in "word", with: "hello"
  #   click_on "Play"

  #   assert_text "Congratulations!"
  # end

  test "saying a word not in grid gives an error" do
    visit new_url
    fill_in "word", with: "???"
    click_on "Play"

    assert_text "can't be built out of"
  end

end
