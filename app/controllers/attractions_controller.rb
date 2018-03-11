class AttractionsController < ApplicationController

  def index
    @attractions = Attraction.all
  end

  def show
    @attraction = Attraction.find(params[:id])
  end

  def new
    @attraction = Attraction.new
  end

  def edit
    @attraction = Attraction.find(params[:id])
  end

  def create
    @attraction = Attraction.new(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      redirect_to new_attractions_path
    end
  end

  def update
    @attraction = Attraction.find(params[:id])
    @attraction.update(attraction_params)
    redirect_to attraction_path(@user)
  end

  def ride
    @attraction = Attraction.find_by(id: params[:attraction][:id])
    current_user.tickets = current_user.tickets - @attraction.tickets
    current_user.happiness = current_user.happiness - @attraction.happiness_rating
    current_user.save
    #binding.pry
    redirect_to current_user
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :min_height, :tickets, :happiness_rating, :nausea_rating)
  end

end
