class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_featured_blogs
  before_action :set_locale

  protected

  #returns blogs that have at least one articles
  def set_featured_blogs
    # joins uses an inner join by default so using User.joins(:articles)
    # will in effect only return users that have an associated articls.
    @featured_users = User.joins(:articles).uniq
  end

  def set_locale
    # several available options
    # pass the locale
    #  * via a parameter
    #  * via dynamic segment in routes
    #  * depending on the domain name
    # here we use the session to store the locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def i18n_model_name(model)
    model.try(:class).try(:model_name).try(:human).try(:downcase)
  end
end
