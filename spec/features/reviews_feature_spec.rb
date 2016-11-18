require 'rails_helper'

feature 'reviewing' do
  before do
    helper_sign_in
    helper_create_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Frank Doubles'
    fill_in "Thoughts", with: "Amazing"
    select '4', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('Amazing')
  end

end
