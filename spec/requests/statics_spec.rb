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

  it "should have the right link destinations" do
    visit root_path
    click_link "About"
    expect(page).to have_content("About #{base_title}")
    click_link "Sign in"
    expect(page).to have_content("Sign in")
    click_link "Where to Watch"
    expect(page).to have_content("Where to Watch")
    click_link "Sign up"
    expect(page).to have_content("Sign up")
  end
end
