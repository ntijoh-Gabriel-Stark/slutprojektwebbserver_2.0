require_relative 'spec_helper'

feature "Login" do
	scenario "Start page has a login form" do
		visit "/"
		expect(page).to have_content "Log In"
		fill_in('name', with: 'Gabriel Stark')
		fill_in('pwd', with: 'hejhej123')
		click_on('Log In')
		expect(page).to have_content "Gabriel Stark"
	end
end

feature "Add" do
	scenario "Add page has add form" do
		visit "/"
		fill_in('name', with: 'Gabriel Stark')
		fill_in('pwd', with: 'hejhej123')
		click_on('Log In')
		visit "/add"
		expect(page).to have_content "Lägg till"
	end
end

feature "Groups" do
	scenario "Group page has groups" do
		visit "/"
		fill_in('name', with: 'Gabriel Stark')
		fill_in('pwd', with: 'hejhej123')
		click_on('Log In')
		visit "/groups"
		expect(page).to have_content "Alla grupper"
	end
end