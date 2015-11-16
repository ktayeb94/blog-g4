class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_article
  before_action :set_comment, only: [:report, :destroy]


  # POST /blog/:blog_name/:article_id/comments
  def create
    @comment = @article.comments.build(comment_params.merge(:user => current_user))

    if @comment.save
      redirect_to article_path(@user.blog_name, @article), notice: 'Comment was successfully created.'
    else
      render 'new'
    end
  end

  # POST /blog/:blog_name/:article_id/comments/1/report
  def report
    @comment.report_count += 1
    @comment.save
    redirect_to article_path(@user.blog_name, @article), notice: 'Thanks for reporting'
  end

  # DELETE /blog/:blog_name/:article_idcomments/1
  def destroy
    @comment.destroy
    redirect_to article_path(@user.blog_name, @article), notice: 'Comment was successfully destroyed.'
  end

  private
  def set_article
    @article =  @user.articles.find(params[:article_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @article.comments.find(params[:id]);
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user
    @user = User.find_by_blog_name(params[:blog_name])
  end
end
