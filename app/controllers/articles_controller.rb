		class ArticlesController < ApplicationController
			skip_before_action :verify_authenticity_token
			def index
				@articles = Article.all;
				respond_to do |format|
				  format.json { render json: {status: 'SUCCESS', message: 'Loaded all articles', articles: @articles},status: :ok }
				  format.html
				 end
			end

			def show
				@article = Article.find(params[:id])
				respond_to do |format|
					format.json { render json: {status: 'SUCCESS', message: 'Loaded article', articles: @article},status: :ok }
					format.html 
				end
			end

			def new
				@article = Article.new(article_params)
			end

			def create
				article = Article.create(params.require(:article).permit(:title, :text))
				if article.save
					respond_to do |format|
						format.json { render json: {status: 'SUCCESS', message: 'Created article', articles: article},status: :ok }
						format.html { redirect_to article}
					end
				else
					respond_to do |format|
						format.json { render json: {status: 'ERROR', message: 'Article not saved', articles: article.errors},status: :error  }
						format.html { redirect_to new_article_path }
					end					
				end
			end

			def destroy
				article = Article.find(params[:id])
				article.destroy
				respond_to do |format|
						format.json { render json: {status: 'SUCCESS', message: 'Article deleted', articles: article},status: :ok  }
						format.html { redirect_to articles_path}
					end	
			end

			def edit
				@article = Article.find(params[:id])
			end

			def update
				article = Article.find(params[:id])
				if article.update_attributes(params.require(:article).permit(:title, :text))
					respond_to do |format|
						format.json { render json: {status: 'SUCCESS', message: 'Article updated', articles: article},status: :ok   }
						format.html { redirect_to article_path }
					end	
				else					
					respond_to do |format|
						format.json { render json: {status: 'ERROR', message: 'Article not updated', articles: article.errors},status: :error }
						format.html { redirect_to article_path }
					end	
				end 
			end

			private
				def article_params
					params.permit(:title, :text)
				end
		end
