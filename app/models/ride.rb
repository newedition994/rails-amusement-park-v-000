class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :user
  belongs_to :attraction

  def take_ride
    enough_tickets, tall_enough = self.meet_requirements
    if enough_tickets && tall_enough
      self.start_ride
    elsif tall_enough && !enough_tickets
      "Sorry." <<  self.ticket_shortage
    elsif enough_tickets && !tall_enough
      "Sorry." <<  self.not_tall_enough
    else
      "Sorry." << self.ticket_shortage << " " << self.not_tall_enough
    end
  end

  def meet_requirements
    enough_tickets, tall_enough = false
    if self.user.tickets >= self.attraction.tickets
      enough_tickets = true
    end
    if self.user.height >= self.attraction.min_height
      tall_enough = true
    end
    [enough_tickets, tall_enough]
  end

  def start_ride
    updated_tickets = self.user.tickets - self.attraction.tickets
    updated_nausea = self.user.nausea + self.attraction.nausea_rating
    updated_happiness = self.user.happiness + self.attraction.happiness_rating

    self.user.update(
      tickets: updated_tickets,
      nausea: updated_nausea,
      happiness: updated_happiness
    )

    "Thanks for riding the #{self.attraction.name}!"
  end

  def ticket_shortage
    " You do not have enough tickets to ride the #{self.attraction.name}."
  end

  def not_tall_enough
    " You are not tall enough to ride the #{self.attraction.name}."
  end

end
