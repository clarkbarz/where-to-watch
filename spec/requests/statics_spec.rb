require 'spec_helper'

describe "Static" do

	let(:base_title) { "Where to Watch" }

  describe "Home page" do

    it "should have the content 'Where to Watch'" do
      visit '/static/home'
      expect(page).to have_content("#{base_title}")
    end

    it "should have the right title" do
    	visit '/static/home'
    	expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe "About page" do

  	it "should have the content 'About Where to Watch'" do
  		visit '/static/about'
  		expect(page).to have_content("About #{base_title}")
  	end

  	it "should have the right title" do
  		visit '/static/about'
  		expect(page).to have_title("#{base_title} | About")
  	end
  end
end
