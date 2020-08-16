class ProductsController < ApplicationController
  before_action :check_permission,  only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = Product.all
    # @products.each do |p|
    #   if p.categories.count == 0
    #     p.destroy
    #   end
    # end
  end

  def show
    @product = Product.find(params[:id])
    @order = Order.where(user: current_user, product: @product).first
  end


    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      @category_array = params.dig(:product, :category_ids)
      if @category_array.class == NilClass
        nocat = true
      end
      if @product.save && !nocat
        @category_array = params.dig(:product, :category_ids)
        @category_array.each do |cat|
          @category = Category.find(cat)
          @product.categories << @category
        end
        flash[:notice] = "product #{@product.name} Added Successsfully"
        redirect_to products_path
      else
        flash[:alert] = "product cant be blank"
        render :edit
      end
    end

    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:format])
      @category_array = params.dig(:product, :category_ids)
      if @category_array.class == NilClass
        nocat = true
      end
      if @product.update(product_params) && !nocat
        @product.product_categories.delete_all
        @category_array = params.dig(:product, :category_ids)
        @category_array.each do |cat|
          @category = Category.find(cat)
          @product.categories << @category
        end
        flash[:notice] = "Product Updated Successsfully"
        redirect_to products_path
      else
        if nocat
          flash.now[:alert] = "Categories cant be blank"
        end
        render :edit
      end
    end

    def destroy
      @product =  Product.find(params[:format])
      @orders = Order.where(product: @product)
      if @orders.count > 0
        @orders.each do |order|
          order.destroy
        end
      end
      @product.destroy
      flash[:notice] = "Product Removed"
      redirect_to products_path
    end

    def product_params
      params.require(:product).permit([:name, :categories, :price, :description])
    end

    private

    def admin?
      current_user.isadmin
    end

    def check_permission
      redirect_back(fallback_location: browse_path) unless admin?
    end
end
