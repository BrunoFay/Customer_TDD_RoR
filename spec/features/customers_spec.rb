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
    expect(page).to have_button('criar')
  end

  scenario "create a customer" do
    new_customer = {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png"),
      smoker: ['S','N'].sample
    }
    visit(new_customer_path)
    fill_in("customer_name", with: new_customer[:name])
    fill_in("customer_email", with: new_customer[:email])
    fill_in("customer_phone", with: new_customer[:phone])
    attach_file("customer_avatar", new_customer[:avatar].path)
    choose(option: new_customer[:smoker])
    click_on('criar')

    expect(page).to have_content('Cliente criado com sucesso!')
    expect(Customer.last.name).to eql(new_customer[:name])
  end

  scenario "fail to create a new customer" do
    new_customer = { smoker: ['S','N'].sample }
    visit(new_customer_path)

    choose(option: new_customer[:smoker])
    click_on('criar')

    expect(page).to have_content("não pode ficar em branco")
  end
end
