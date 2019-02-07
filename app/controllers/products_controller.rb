class ProductsController < ApplicationController

  def index
    @product = Product.all
    # flash[:notice] = "Data imported successfully"
    # redirect_to export_path()
  end

  def show
    
  end

  def new
    @product = Product.new
  end

  def import
    Product.import(params[:file])
    # puts"------------------------------------hello"
    # puts params[:file]
    redirect_to export_path()
    # flash[:notice] = "Data imported successfully"
  end

  def export

    # flash[:notice] = "Data imported successfully"
    
    # redirect_to products_path(method: :get)
    # flash[:notice] = "Data exported successfully"
  
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to root_url, notice: "Imported products successfully."
    else
      render :new
    end

    # Product.import(params[:file])
    # flash[:notice] = "Data imported"
    # redirect_to products_path()
  end

  def edit

  end

  def update

  end
end
