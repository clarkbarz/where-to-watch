require 'spec_helper'

describe "Static" do

	let(:base_title) { "Where to Watch" }
	subject { page }

  describe "Home page" do

  	before { visit root_path }

    it { should have_content("#{base_title}") }
    it { should have_title(full_title('Home')) }
  end

  describe "About page" do

  	before { visit about_path }

  	it { should have_content("About #{base_title}") }
  	it { should have_title(full_title('About')) }
  end
end
