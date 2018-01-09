class ArticlesController < ApplicationController
  protect_from_forgery :only => [:update, :delete, :create]

  def index
    @articles = Article.all
    respond_to do |format|
      format.json { render json: { message: "All articles", articles: @articles }, status: :ok }
      format.html
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.json { render json: { message: "Loaded article", article: @article, comments: @article.comments }, status: :ok }
      format.html 
    end
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Not found" }, status: :not_found }
        format.html 
      end
  end

  def new
    @article = Article.new()
  end

  def create
    article = Article.create(article_params)
    if article.save
      respond_to do |format|
        format.json { render json: { message: "Created article", article: article }, status: :ok }
        format.html { redirect_to article}
      end
    else
      respond_to do |format|
        format.json { render json: { message: article.errors }, status: :unprocessable_entity  }
        format.html { redirect_to new_article_path }
      end                 
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    respond_to do |format|
      if article.destroy
        format.json { render json: { article: article}, status: :ok }
        format.html { redirect_to articles_path}
      else
        format.json { render json: { message: article.errors }, status: :unprocessable_entity }
        format.html { redirect_to article_path }
      end 
    end 
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Not found" }, status: :not_found }
        format.html 
      end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    if article.update_attributes(article_params)
      respond_to do |format|
        format.json { render json: { message: "Article updated", article: article}, status: :ok }
        format.html { redirect_to article_path }
      end 
    else                    
      respond_to do |format|
        format.json { render json: { message: article.errors }, status: :unprocessable_entity }
        format.html { redirect_to article_path }
      end 
    end 
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.json { render json: { message: "Not found" }, status: :not_found }
        format.html 
      end
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end