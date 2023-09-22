require 'rails_helper'

feature "Welcomes", type: :feature do
  before(:each){ visit('/') }
  scenario "show welcome message" do
    expect(page).to have_content("Welcome to tdd RoR app")
  end
  scenario "page has a link with text 'Cadastro de clientes'" do
    expect(find('ul li')).to have_link('Cadastro de clientes') #this format search a link inside ul li with that text
  end
end
