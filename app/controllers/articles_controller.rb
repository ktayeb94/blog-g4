class ArticlesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :set_user
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /blog/:blog_name
  def index
    @articles = @user.articles
  end

  # GET  /blog/:blog_name/:id
  def show
    @comments = @article.comments.order(:created_at => "asc")
    @comment = @article.comments.build
  end

  # GET /blog/:blog_name/new
  def new
    @article = @user.articles.build
  end

  # GET /blog/:blog_name/:id/edit
  def edit
  end

  # POST /blog/:blog_name
  def create
    @article = @user.articles.build(article_params)


    if @article.save
      redirect_to article_path(@user.blog_name, @article), notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /blog/:blog_name/:id
  def update

    if @article.update(article_params)
      redirect_to article_path(@user.blog_name, @article), notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /blog/:blog_name/:id
  def destroy
    @article.destroy
    redirect_to articles_url(@user.blog_name), notice: 'Article was successfully destroyed.'
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
    @user = User.find_by_blog_name(params[:blog_name])
  end
end
