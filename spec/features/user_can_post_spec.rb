require 'rails_helper'

RSpec.feature "New posts", type: :feature do
  scenario "Can submit posts and view them" do
    sign_in
    click_on "Add new"
    fill_in "Title", with: "Hello, world!"
    attach_file('post_photo', Rails.root + "spec/factories/Trollface.png")
    click_button "Upload"
    expect(page).to have_content "Hello, world!"
  end

  scenario "Can submit post and see author name" do
    user = create(:user)
    visit posts_url(as: user)
    click_on "Add new"
    fill_in "Title", with: "Hello, world!"
    attach_file('post_photo', Rails.root + "spec/factories/Trollface.png")
    click_button "Upload"
    within ".card" do
      expect(page.find('.title').text).to eq user.username
    end
  end

  scenario "Can submit post and see author profile picture" do
    user = create(:user)
    visit posts_url(as: user)
    click_on "Add new"
    fill_in "Title", with: "Hello, world!"
    attach_file('post_photo', Rails.root + "spec/factories/Trollface.png")
    click_button "Upload"

    within ".card .media-left" do
      expect(page).to have_css "img[src*='Trollface.png']"
    end
  end
end
