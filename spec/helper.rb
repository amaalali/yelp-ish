def sign_in
  User.create(email: 'test@notanemail.com', password: '123456')
  visit '/restaurants'
  click_link 'Sign in'
  fill_in 'user[email]', with: 'test@notanemail.com'
  fill_in 'user[password]', with: '123456'
  click_button 'Log in'
end
