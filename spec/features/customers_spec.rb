require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario "access customers index by root path" do
    visit(root_path)
    click_on('Cadastro de clientes')
    expect(page).to have_content('Lista de clientes')
  end

  scenario "access new customer form by customers index page" do
    visit(customers_path)
    expect(page).to have_link('Novo cliente')
    click_on('Novo cliente')
    expect(find('h1')).to have_content('Novo cliente')
    expect(page).to have_selector(:link_or_button, :text => 'criar')
  end
end
