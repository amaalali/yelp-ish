def sign_in
  visit('/')
  click_link('Sign in')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  click_button('Sign in')
end

def sign_up
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: 'test@example.com')
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_out
  visit('/')
  click_link('Sign out')
end

def add_restaurant
  visit('restaurants/new')
  fill_in('Name', with: 'KFC')
  click_button('Create Restaurant')
end

def helper_sign_in
  helper_create_user unless User.find_by(email: 'test@notanemail.com')
  visit '/restaurants'
  click_link 'Sign in'
  fill_in 'user[email]', with: 'test@notanemail.com'
  fill_in 'user[password]', with: '123456'
  click_button 'Log in'
end

def helper_create_restaurant(name: 'Frank Doubles',
                             description: 'The best doubles in TnT')
  user = User.find_by(email: 'test@notanemail.com') || helper_create_user
  Restaurant.create name: name,
                    description: description,
                    user_id: user.id
end

def helper_create_user(email: 'test@notanemail.com', password: '123456')
  User.create(email: email, password: password)
end

def helper_sign_in_2
  helper_create_user(email: 'test2@notanemail.com', password: '1234567') unless User.find_by(email: 'test2@notanemail.com')
  visit '/restaurants'
  click_link 'Sign in'
  fill_in 'user[email]', with: 'test2@notanemail.com'
  fill_in 'user[password]', with: '1234567'
  click_button 'Log in'
end
