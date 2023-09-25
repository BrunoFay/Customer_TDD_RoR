class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show, :destroy]
  def index
    @customers = Customer.all
  end
  def show

  end
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path, notice: "Cliente criado com sucesso!"
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_path(@customer), notice: "Cliente atualizado com sucesso"
    else
      render :edit
    end
  end

  def edit
  end
  def destroy
    if @customer.destroy
      redirect_to customers_path, notice: "Cliente excluido com sucesso"
    else
      render :index
    end
  end

  private

  def set_customer
    @customer = Customer.find_by_id(params[:id])
  end
  def customer_params
    params.require(:customer).permit(:id, :name, :email, :phone, :avatar, :smoker)
  end

end
