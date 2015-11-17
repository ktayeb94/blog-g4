class Ability
  include CanCan::Ability

  def initialize(current_user)

    can :index, Article

    can :show, Article

     can [:new, :create, :edit, :update, :destroy], Article do |article|
      article.user == current_user
    end

    can :report, Comment do |comment|
      !current_user.nil? && comment.user != current_user
    end


    can :create, Comment do
      !current_user.nil?
    end
    can :destroy, Comment do |comment|
      comment.user == current_user || comment.article.user == current_user
    end
  end
end
