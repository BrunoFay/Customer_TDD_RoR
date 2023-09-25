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

  scenario "show a customer" do
    customer = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png"),
      smoker: ['S','N'].sample
    )
    visit(customers_path(customer))
    expect(page).to have_content(customer[:name])
    expect(page).to have_content(customer[:email])
    expect(page).to have_content(customer[:phone])
  end

  scenario "customer index" do
    customer_one = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png"),
      smoker: ['S','N'].sample
    )
    customer_two = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png"),
      smoker: ['S','N'].sample
    )
    visit(customers_path)
    expect(page).to have_content(customer_one.name).and have_content(customer_two.name)
  end

  scenario "edit customer" do
    customer = Customer.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number,
      avatar: Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/avatar.png", "image/png"),
      smoker: ['S','N'].sample
    )
    new_name = Faker::Name.name

    visit(edit_customer_path(customer))
    fill_in("customer_name", with: new_name)
    click_on("Atualizar")

    expect(page).to have_current_path(customers_path(customer))
    expect(page).to have_content("Cliente atualizado com sucesso")
    expect(page).to have_content(new_name)
  end
end
