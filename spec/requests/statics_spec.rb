require 'spec_helper'

describe "Static" do

	let(:base_title) { "Where to Watch" }

  describe "Home page" do

    it "should have the h1 'Where to Watch'" do
      visit root_path
      expect(page).to have_content("#{base_title}")
    end

    it "should have the right title" do
    	visit root_path
    	expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe "About page" do

  	it "should have the content 'About Where to Watch'" do
  		visit about_path
  		expect(page).to have_content("About #{base_title}")
  	end

  	it "should have the right title" do
  		visit about_path
  		expect(page).to have_title("#{base_title} | About")
  	end
  end
end
