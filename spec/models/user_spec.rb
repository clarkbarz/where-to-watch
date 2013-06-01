require 'spec_helper'

describe User do

  before { @user = User.new(email: "email@example.org", password: "jeremiah", password_confirmation: "jeremiah") }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token)}

  it { should be_valid }

  describe "when user email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when user email is an invalid format" do
  	invalid_emails = %w["foo@exxon", "user_foo.org", "foo@user,com", "guy@friend_com.org" "guy.friend.com", "example@foo.", "guy@..exx", "friend@foo+baz.com" "neder@jimmy..fresh"]
  	invalid_emails.each do |invalid|
  		before { @user.email = invalid }
  		it { should_not be_valid }
  	end
  end

  describe "when user email is in valid format" do
  	valid_emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  	valid_emails.each do |valid|
  		before { @user.email = valid }
  		it { should be_valid }
  	end
  end

  describe "when email address is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.upcase
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before do
  		@user = User.new(email: "ben@dover.com", password: "flight",password_confirmation: "johnson")
  	end
  	it { should_not be_valid}
  end

  describe "when password confirmation is nil" do
  	before do
  		@user = User.new(email: "kurt@fan4.com", password: "crab_dip", password_confirmation: nil)
  	end
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by(email: @user.email) }

  	describe "with valid password" do
  		it { should eq found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("invalid") }

  		it { should_not eq user_for_invalid_password }
  		specify { expect(user_for_invalid_password).to be_false }
  	end
  end

  describe "with a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  	it { should be_invalid }
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
