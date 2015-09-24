feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  def sign_up(email: 'alice@example.com',
              password: 'oranges!')
      visit '/users/new'
      expect(page.status_code).to eq(200)
      fill_in :email, with: email
      fill_in :password, with: password
      click_button 'Sign Up'
  end

  scenario 'requires a matching comfirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end

  def sign_up(email: 'alice@example.com',
              password: '12345678',
              password_confirmation: '12345678')
   visit '/users/new'
   fill_in :email, with: email
   fill_in :password, with: password
   fill_in :password_confirmation, with: password_confirmation
   click_button 'Sign Up'
  end

  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario 'requires an email to sign up' do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Please enter an email address'
  end



end