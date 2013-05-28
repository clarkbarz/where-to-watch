require 'spec_helper'

describe "Static" do

  describe "Home page" do

    it "should have the content 'Where to Watch'" do
      visit '/static/home'
      expect(page).to have_content('Where to Watch')
    end

    it "should have the right title" do
    	visit '/static/home'
    	expect(page).to have_title('Where to Watch | Home')
    end
  end

  describe "About page" do

  	it "should have the content 'About Where to Watch'" do
  		visit '/static/about'
  		expect(page).to have_content('About Where to Watch')
  	end

  	it "should have the right title" do
  		visit '/static/about'
  		expect(page).to have_title('Where to Watch | About')
  	end
  end
end
