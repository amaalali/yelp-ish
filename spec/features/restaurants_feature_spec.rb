require 'rails_helper'

feature 'Restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'have been added' do
    before { helper_create_restaurant }

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'Frank Doubles'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating' do
    context 'user logged-in' do
      before(:each) do
        visit '/restaurants'
        helper_sign_in
        click_link 'Add a restaurant'
      end

      scenario 'prompts user to fill out form, then new restaurant displayed' do
        fill_in 'Name', with: 'KFC'
        click_button 'Create Restaurant'
        expect(page).to have_content 'KFC'
        expect(current_path).to eq '/restaurants'
      end

      context 'an invalid restaurant' do
        scenario 'does not let you submit a name that is too short' do
          # visit '/restaurants'
          # click_link 'Add a restaurant'
          fill_in 'Name', with: 'kf'
          click_button 'Create Restaurant'
          expect(page).not_to have_css 'h2', text: 'kf'
          expect(page).to have_content 'error'
        end
      end
    end

    context 'user not logged-in' do
      scenario 'User prompted to login' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(page).not_to have_content 'Create Restaurant'
        expect(page).to have_content(
          'You need to sign in or sign up before continuing.'
        )
      end
    end
  end

  context 'viewing restaurants' do
    let!(:frank) { helper_create_restaurant }

    scenario 'in detail' do
      visit '/restaurants'
      click_link 'Frank Doubles'
      expect(page).to have_content 'Frank Doubles'
      expect(current_path).to eq "/restaurants/#{frank.id}"
    end
  end

  context 'editing restaurants' do
    before(:each) { helper_create_restaurant }

    context 'user logged-in' do
      scenario 'user that created = user that edits' do
        helper_sign_in
        visit '/restaurants'
        click_link 'Edit Frank Doubles'
        fill_in 'Name', with: 'Frank Doubles Edit'
        fill_in 'Description', with: 'The best doubles in TnT Edit'
        click_button 'Update Restaurant'
        expect(page).to have_content 'Frank Doubles Edit'
        expect(page).to have_content 'The best doubles in TnT Edit'
        expect(current_path).to eq '/restaurants'
      end

      scenario 'user that created = user that edits' do
        helper_sign_in_2
        visit '/restaurants'
        click_link 'Edit Frank Doubles'
        expect(page).to have_content 'Frank Doubles'
        expect(page).to have_content 'Sorry, you cannot perform delete/edit this restaurant'
      end
    end


    context 'user signed-out' do
      before(:each) do
        visit '/restaurants'
        click_link 'Edit Frank Doubles'
      end

      scenario 'prompts user to sign-in' do
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end

      scenario 'restaurant still listed' do
        visit '/restaurants'
        expect(page).to have_content 'Frank Doubles'
      end
    end
  end

  context 'deleting restaurants' do
    before(:each) { helper_create_restaurant }

    context 'user logged-in' do
      scenario 'user that created = user that deletes' do
        helper_sign_in
        visit '/restaurants'
        click_link 'Delete Frank Doubles'
        expect(page).not_to have_content 'Frank Doubles'
        expect(page).to have_content 'Restaurant deleted successfully'
      end

      scenario 'user that created = user that deletes' do
        helper_sign_in_2
        visit '/restaurants'
        click_link 'Delete Frank Doubles'
        expect(page).to have_content 'Frank Doubles'
        expect(page).to have_content 'Sorry, you cannot perform delete/edit this restaurant'
      end
    end


    context 'user signed-out' do
      before(:each) do
        visit '/restaurants'
        click_link 'Delete Frank Doubles'
      end

      scenario 'prompts user to sign-in' do
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end

      scenario 'restaurant still listed' do
        visit '/restaurants'
        expect(page).to have_content 'Frank Doubles'
      end
    end
  end
end
