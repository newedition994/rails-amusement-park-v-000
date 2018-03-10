class RidesController < ApplicationController
  def new
    @ride = Ride.new(attraction: Attraction.find_by(id: params[:attraction][:id]), user: current_user)
    flash[:alert] = @ride.take_ride
    @ride.start_ride
    redirect_to user_path(@user)
  end
end
