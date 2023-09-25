class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    def top
    end
    
    def index
        @posts = Post.all

        if params[:tag_ids]
          @posts = []
          params[:tag_ids].each do |key, value|      
            @posts += Tag.find_by(name: key).posts if value == "1"
          end
          @posts.uniq!
        end

        if params[:tag]
          Tag.create(name: params[:tag])
        end

        if params[:search] == nil
          @post = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
        elsif params[:search] == ''
          @post = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
        else

          @post = Post.where("storename LIKE ? OR menu LIKE ? OR place LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
        end

    end
    
    def new
        @post = Post.new
      end
    
      def create
        post = Post.new(post_params)

        post.user_id = current_user.id

        if post.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end
    
      def show
        @post = Post.find(params[:id])
      end

      def edit
        @post = Post.find(params[:id])
      end

      def update
        post = Post.find(params[:id])
        if post.update(post_params)
          redirect_to :action => "show", :id => post.id
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
      end

      def store
        @posts = Post.all
      end
    
      def food
        @posts = Post.all
      end
    
      def animal
        @posts = Post.all
      end

      private
       def post_params
         params.require(:post).permit(:image, :comment, :place, :category, :body, tag_ids: [])
       end

end
