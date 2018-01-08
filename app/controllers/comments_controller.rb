class CommentsController < ApplicationController
  protect_from_forgery :only => [:delete, :create]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    respond_to do |format|
      format.json { render json: { comments: @comment },status: :ok }
      format.html { redirect_to article_path(@article) }
    end
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.json { render json: { comment: @comment },status: :ok }
      format.html { redirect_to article_path(@article) }
    end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { comment: "Not found" }, status: :unprocessable_entity }
        format.html { redirect_to article_path(@article) }
      end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
