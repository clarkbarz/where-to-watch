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
   	end

   	describe "with valid information" do
   		before do
 				fill_in "Email", with: "example@friend.com"
 				fill_in "Password", with: "uglygoat"
 				fill_in "Password Confirmation", with: "uglygoat"
 			end
			it "should create a user" do
   			expect { click_button submit }.to change(User, :count)
   		end
   	end
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_content(user.email) }
  end
end
