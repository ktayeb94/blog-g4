class WelcomeController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc).limit(10)
  end

  def change_locale
    session[:locale] = if params[:locale].in? ['en', 'fr']
                         params[:locale].to_sym
                       else
                         nil
                       end
    # not suitable for production but useful for this course
    redirect_to :back
  end
end
