class UsersController < ApplicationController
  include MainConcern

  before_action :set_user, only: %i[ show edit update destroy ] #before function is called before doing any function
  before_action :is_logged_in, only: %i[ show edit destroy ]
  before_action only: %i[ show edit destroy ] do
    if @user
      is_the_right_user(@user.id)
    else
      is_the_right_user(-1)
    end
  end

  #after action

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }  #redirect to show the user
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity } # if user requests in html format, use this.
        format.json { render json: @user.errors, status: :unprocessable_entity } # otherwise 
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }  #422 status
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def create_fast

    @user = User.new(fast_user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id]) rescue nil
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :birthday, :address, :postal_code, :password)  #<<-------  security
    end

    def fast_user_params
      return {name: params[:name], email: params[:email]}
    end
end
