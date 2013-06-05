FactoryGirl.define do
	factory :user do
		sequence(:email) { |n| "man_no_#{n}@me.com" }
		# email "clarkbarz@me.com"
		password "friendlydragon"
		password_confirmation "friendlydragon"
	end
end