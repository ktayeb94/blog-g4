class ArticlesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_user
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /blog/:username
  def index
    authorize! :index, Article
    @articles = @user.articles
  end

  # GET  /blog/:username/:id
  def show
    authorize! :show, @article
    @comments = @article.comments.order(:created_at => "asc")
    @comment = @article.comments.build
  end

  # GET /blog/:username/new
  def new
    @article = @user.articles.build
    authorize! :new, @article
  end

  # GET /blog/:username/:id/edit
  def edit
    authorize! :edit, @article
  end

  # POST /blog/:username
  def create
    @article = @user.articles.build(article_params)
    authorize! :create, @article

    if @article.save
      redirect_to article_path(@user.username, @article), notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /blog/:username/:id
  def update
    authorize! :update, @article
    if @article.update(article_params)
      redirect_to article_path(@user.username, @article), notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /blog/:username/:id
  def destroy
    authorize! :destroy, @article
    @article.destroy
    redirect_to articles_url(@user.username), notice: 'Article was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = @user.articles.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :text)
  end

  def set_user
    @user = User.find_by_username(params[:username])
  end
end
