class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:report, :destroy]


  # POST /comments
  def create
    @comment = @article.comments.build(comment_params)

    if @comment.save
      redirect_to article_path(@article), notice: 'Comment was successfully created.'
    else
      render 'new'
    end
  end

  # POST /comments/1/report
  def report
    @comment.report_count += 1
    @comment.save
    redirect_to article_path(@article), notice: 'Thanks for reporting'
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to article_path(@article), notice: 'Comment was successfully destroyed.'
  end

  private
  def set_article
    @article =  Article.find(params[:article_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = @article.comments.find(params[:id]);
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:text)
  end
end
