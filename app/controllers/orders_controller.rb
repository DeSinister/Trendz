class OrdersController < ApplicationController

  def cart
    @orders = current_user.products
  end

  # def show
  #   @order = Order.find(params[:id])
  #   @product = Product.find(@order.product)
  # end

  def new
    @product = Product.find(params[:id])
    @order = Order.new
  end

  def create
    @order = Order.create(product_id: params[:product_id], user: current_user)
    @order.quantity = params[:order][:quantity].to_i
    @order.save!
    if @order.save
      flash[:notice] = "#{@order.quantity} of #{@order.product.name} costing #{@order.quantity * @order.product.price} Added to the cart Successsfully"
      redirect_to my_cart_path
    else
      flash[:notice] = "An error Occurred"
      render 'orders/new'
    end
  end

  def edit
    @order = Order.find(params[:format])
    @product = Product.find(@order.product.id)
  end

  def update
    @order = Order.find(params[:id])
    @order.quantity = params[:order][:quantity].to_i
    @order.save!
    if @order.save
      flash[:notice] = "#{@order.quantity} of #{@order.product.name} costing #{@order.quantity * @order.product.price} updated to the cart Successsfully"
      redirect_to my_cart_path
    else
      flash[:notice] = "An error Occurred"
      render 'orders/edit'
    end
  end

  def destroy
    @order = Order.find(params[:format])
    @order.destroy
    flash[:notice] = "Successfully Removed from the cart"
    redirect_to my_cart_path
  end

  def order_params
    params.require(:order).permit(:product, :user, :quantity)
  end

end
