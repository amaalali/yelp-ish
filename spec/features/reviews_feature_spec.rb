require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    helper_sign_in
    add_restaurant
    visit '/restaurants'
    click_link "Review KFC"
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    click_link 'KFC'
    expect(page).to have_content('so so')
  end
end
