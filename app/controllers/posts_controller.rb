class PostsController < ApplicationController
  def index
    render json: Post.all, status: :ok
  end

  def create
    new_post = Post.new posts_params

    return render json: new_post, status: :ok if new_post.save
    
    render json: {errors: new_post.errors.full_messages}, status: :unprocessable_entity
  end

  def destroy

    post_to_destroy = Post.find_by(id: params[:id])
    if post_to_destroy
      post_to_destroy.destroy
      render json: post_to_destroy, status: :ok
    else
      render json: {error: 'Could not find the post id'}, status: :unprocessable_entity
    end
  end

  private

  def posts_params
    params.permit(:name, :description)
  end
end
