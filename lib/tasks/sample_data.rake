namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!( email: "example@clarkbarz.com",
									password: "redrum",
									password_confirmation: "redrum",
									admin: true )
		99.times do |n|
			email = "example-#{n}@clarkbarz.com"
			password = "password"
			User.create!(	email: email,
										password: password,
										password_confirmation: password )
		end
	end
end