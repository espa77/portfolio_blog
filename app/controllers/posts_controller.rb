class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		binding.pry
		@posts = JSON.parse(RestClient.get("https://medium.com/learning-living")).paginate(page: params[:page], per_page: 3)
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new post_params
		if @post.save
			redirect_to @post, notice: "Keep on trucking, Ethan! Your article was successfully saved!"
		else
			render 'new', notice: "Oh no Brah! I was unable to save your post."
		end
	end

	def show

	end

	def edit
	end

	def update
		if @post.update post_params
			redirect_to @post, notice: "Wat! Your article was successfully saved!"
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :slug, :attachment)
	end

	def find_post
		@post = Post.friendly.find(params[:id])
	end
end
