class PostsController < ApplicationController
  include MainConcern

  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :is_logged_in, only: %i[ new show edit destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.user_id = session[:user_id]   # <<---------
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.valid_user_id(session[:user_id]) && @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }  # <<---------
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update

    checkID = post_params[:user_id].to_i rescue nil
    if @post.valid_user_id(checkID)
      @post.valid_user_id(session[:user_id])
    end

    respond_to do |format|
      if !@post.errors.any? && @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }  # <<---------
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.valid_user_id(session[:user_id])

    
    respond_to do |format|
      if !@post.errors.any? 
        @post.destroy
        format.html { redirect_to feed_path(@post.user_id), notice: "Post was successfully destroyed." }  # <<---------
        format.json { head :no_content }
      else 
        format.html { redirect_to posts_path, alert: "You have no permission to perform this action."}
      end  
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :msg)
    end
end
