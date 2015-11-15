class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:report, :destroy]


  # POST /comments
  # POST /comments.json
  def create
    @comment = @article.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_path(@article), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def report
     @comment.report_count += 1
     @comment.save
     redirect_to article_path(@article), notice: 'Thanks for reporting'
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
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
