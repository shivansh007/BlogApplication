class CommentsController < ApplicationController
  protect_from_forgery :only => [:update, :delete, :create]

  def index
    @comments = Comment.all
    respond_to do |format|
      format.json { render json: { message: "All comments", comments: @comments }, status: :ok }
      format.html
    end
  end

  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.json { render json: { message: "Loaded comment", comment: @comment }, status: :ok }
      format.html 
    end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Not found" }, status: :not_found }
        format.html 
      end
  end

  def new
    @comment = Comment.new(comment_params)
  end

  def create
    @article = Article.find(comment_params[:article_id])
    @comment = Comment.create(comment_params)
    if @comment.save
      respond_to do |format|
        format.json { render json: { message: "Added comment", comment: @comment }, status: :ok }
        format.html { redirect_to article_path(@article) }
      end
    else
      respond_to do |format|
        format.json { render json: { message: comment.errors}, status: :unprocessable_entity }
        format.html { redirect_to articles_path }
      end
    end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Article not found" }, status: :not_found }
        format.html 
      end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes(params.require('comment').permit(:commenter, :body))
      respond_to do |format|
        format.json { render json: { message: "Comment updated", comment: comment}, status: :ok }
        format.html { redirect_to articles_path }
      end 
    else                    
      respond_to do |format|
        format.json { render json: { message: comment.errors}, status: :unprocessable_entity }
        format.html { redirect_to articles_path }
      end 
    end 
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Not found" }, status: :not_found }
        format.html 
      end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.json { render json: { message: "Deleted comment", comment: @comment }, status: :ok }
        format.html { redirect_to articles_path }
      else
        format.json { render json: { message: @comment.errors }, status: :unprocessable_entity }
        format.html { redirect_to articles_path }
      end
    end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Comment not found" }, status: :not_found }
        format.html { redirect_to article_path(@article) }
      end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :article_id)
  end
end