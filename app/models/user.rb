class User < ActiveRecord::Base
  # write associations here
  has_secure_password

  has_many :rides
  has_many :attractions, :through => :rides

  def mood
    if self.happiness && self.nausea
      mood = self.happiness - self.nausea
      mood > 0 ? "happy" : "sad"
    end
  end

  def num_of_rides
    self.attractions.count
  end

  private
  
  def current_user
    @user = User.find_by(params[:name])
  end
end
