class CategoriesController < ApplicationController
  before_action :check_permission,  only: [:new, :create, :edit, :update, :destroy]

  def show
    @category = Category.find(params[:id])
    @products = @category.products.all
  end

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "CAtegory ADded Successsfully"
      redirect_to categories_path
    else
      flash[:alert] = "CAtegory cant be blank"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:format])
    @category.name = params[:category][:name]
    @category.save!
    if @category.save
      flash[:notice] = "Category Updated Successsfully"
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category =  Category.find(params[:format])
    Category.destroy(params[:format])
    # @category.destroy

    flash[:notice] = "Category Removed"
    redirect_to products_path
  end

  def category_params
    params.require(:category).permit(:name)
  end

  private

  def admin?
    current_user.isadmin
  end

  def check_permission
    redirect_back(fallback_location: browse_path) unless admin?
  end
end
