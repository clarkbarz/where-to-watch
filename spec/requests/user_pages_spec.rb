require 'spec_helper'

describe "User pages" do

  subject { page }

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
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Update Information") }
      it { should have_title("Edit user") }
    end

    describe "with invalid information" do
      before do
        click_button "Edit"
        click_button "Save"
      end
      it { should have_content('error') }
    end
  end

  describe "profile" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.email) }
  end
end
