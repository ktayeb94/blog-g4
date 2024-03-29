class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_article
  before_action :set_comment, only: [:report, :destroy]


  # POST /blog/:username/:article_id/comments
  def create
    @comment = @article.comments.build(comment_params.merge(:user => current_user))
    authorize! :create, @comment
    if @comment.save
      redirect_to article_path(@user.username, @article),
                  notice: t('flash_messages.created', :resource_name => i18n_model_name(@comment))
    else
      render 'new'
    end
  end

  # POST /blog/:username/:article_id/comments/1/report
  def report
    authorize! :report, @comment
    @comment.report_count += 1
    @comment.save
    redirect_to article_path(@user.username, @article),
                notice: t('flash_messages.reported')
  end

  # DELETE /blog/:username/:article_id/comments/1
  def destroy
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to article_path(@user.username, @article),
                notice: t('flash_messages.destroyed', :resource_name => i18n_model_name(@comment))
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
    @user = User.find_by_username(params[:username])
  end
end
