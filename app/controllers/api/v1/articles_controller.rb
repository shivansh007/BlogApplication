module Api
	module V1
		class ArticlesController < ApplicationController
			skip_before_action :verify_authenticity_token
			def index
				articles = Article.all;
				render json: {status: 'SUCCESS', message: 'Loaded all articles', articles: articles},status: :ok
			end

			def show
				article = Article.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Loaded article', articles: article},status: :ok
			end

			def create
				article = Article.new(article_params)
				if article.save
					render json: {status: 'SUCCESS', message: 'Saved article', articles: article},status: :ok 
				else
					render json: {status: 'ERROR', message: 'Article not saved', articles: article.errors},status: :error 
				end
			end

			def destroy
				article = Article.find(params[:id])
				article.destroy
				render json: {status: 'SUCCESS', message: 'Article deleted', articles: article},status: :ok 
			end

			def update
				article = Article.find(params[:id])
				if article.update_attributes(article_params)
					render json: {status: 'SUCCESS', message: 'Article updated', articles: article},status: :ok 
				else
					render json: {status: 'ERROR', message: 'Article not updated', articles: article.errors},status: :error 
				end 
			end

			private
				def article_params
					params.permit(:title, :text)
				end
		end
	end
end
