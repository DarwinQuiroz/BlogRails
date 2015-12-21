# encoding: utf-8

class ArticlesController < ApplicationController
	#before_action :validate_user, except: [:show, :index]
	before_action :authenticate_user!, except: [:show, :index]
	before_action :set_article, except: [:index, :new, :create]


	#GET /articles
	def index
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		# @article = Article.find(params[:id])
		@article.update_visits_count
		@comment = Comment.new
	end

	#GET /articles/new
	def new
		@article = Article.new
	end

	def edit
		# @article = Article.find(params[:id])
	end

	#POST /article
	def create
		@article = current_user.articles.new(article_params)

		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def update
		# @article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	def destroy
		# @article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

	private
	def article_params
		params.require(:article).permit(:title,:body)
	end

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end

	def set_article
		@article = Article.find(params[:id])
	end
end