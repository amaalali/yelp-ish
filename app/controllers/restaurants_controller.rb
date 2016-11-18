class RestaurantsController < ApplicationController

before_action :authenticate_user!, :except => [:index, :show]
before_action :require_permisson, only: [:edit, :update, :destroy]

  def index
    @restaurant = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @current_user = current_user
    @restaurant = @current_user.restaurants.new(restaurant_params)

    # @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :user_id)
  end

  def require_permisson
    restaurant = Restaurant.find(params[:id])
    if restaurant.user != current_user
      flash[:notice] = 'You are not the owner of this restuarant'
      redirect_to '/restaurants'
    end
  end


end
