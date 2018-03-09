class Ability
  include CanCan::Ability

  def initializer(user)
    can :read, Attraction
  end

  def user.admin?
    can :manage, Attraction
  end
end
