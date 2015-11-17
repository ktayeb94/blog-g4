class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_featured_blogs

  protected

  #returns blogs that have at least one articles
  def set_featured_blogs
    # joins uses an inner join by default so using User.joins(:articles)
    # will in effect only return users that have an associated articls.
    @featured_users = User.joins(:articles).uniq
  end
end
