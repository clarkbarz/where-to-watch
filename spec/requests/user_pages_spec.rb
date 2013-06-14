require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.email)
        end
      end
    end

    describe "delete links" do
       it { should_not have_link('delete') }

       describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "signup" do
   	before { visit signup_path }

   	let(:submit) { "Create Account!" }

   	it { should have_content('Sign up') }
   	it { should have_title(full_title('Sign up')) }

   	describe "with invalid information" do
   		it "should not create a user" do
   			expect { click_button submit }.not_to change(User, :count)
   		end

   		describe "after submission" do
   			before { click_button submit }

   			it { should have_title('Sign up') }
   			it { should have_content('error') }
   		end
   	end

   	describe "with valid information" do
   		before do
 				fill_in "Email", with: "example@friend.com"
 				fill_in "Password", with: "uglygoat"
 				fill_in "Confirmation", with: "uglygoat"
 			end
			it "should create a user" do
   			expect { click_button submit }.to change(User, :count).by(1)
   		end

   		describe "after saving the user" do
   			before { click_button submit }
   			let(:user) { User.find_by(email: 'example@friend.com') }

   			it { should have_content(user.email) }
   			it { should have_selector('div.alert.alert-success') }
   		end
   	end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update Information") }
      it { should have_title("Edit user") }
    end

    describe "email" do
      describe "with invalid information" do
        before do
          click_button "edit-email"
          click_button "save-email"
        end
        it { should have_selector('div.alert.alert-error') }
      end

      describe "with valid information" do
        let(:new_email) { "new@newey.org" }

        before do
          click_button "edit-email"
          within "#email-form" do
            fill_in "user_email", with: new_email
            fill_in "user_old_password", with: user.password
          end
          click_button "save-email"
        end

        it { should have_content(new_email) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out') }
        specify{ expect(user.reload.email).to eq new_email }
      end
    end

    describe "password" do
      describe "with invalid information" do
        before do
          click_button "edit-password"
          click_button "save-password"
        end

        it { should have_selector('div.alert.alert-error') }
      end

      describe "with valid information" do
        let(:new_password) { "neweyfoo" }
        before do
          click_button "edit-password"
          within "#password-form" do
            fill_in "user_password", with: new_password
            fill_in "user_password_confirmation", with: new_password
            fill_in "user_old_password", with: user.password
          end
          click_button "save-password"
        end

        it { should have_selector('div.alert.alert-success') }
      end
    end

    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password, password_confirmation: user.password } }
      end
      before { patch user_path(user), params }
      specify { expect(user.reload).not_to be_admin }
    end
  end

  describe "profile" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.email) }
  end
end
