class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
      render json: {
        username: @user.username,
        first_name: @user.first_name,
        last_name: @user.last_name,
        email: @user.email,
        phone_number: @user.phone_number
      }, status: :ok
  end

  # curl -X POST -H "Content-Type: application/json" -d '{ "user": { "username": "jfriedman", "first_name": "Jeff", "last_name": "Friedman", "email": "test@test.com", "phone_number": "617-123-4567", "password": "password", "password_confirmation": "password" }}' http://localhost:3000/api/v1/users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        username: @user.username,
        first_name: @user.first_name,
        last_name: @user.last_name,
        email: @user.email,
        phone_number: @user.phone_number
      }, status: :ok
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  # curl -X PUT -H "Content-Type: application/json" -d '{ "user": { "phone_number": "617-111-2222" }}' http://localhost:3000/api/v1/users/1
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.save
      render json: {
        message: "Update successful."
      }, status: :ok
    else
      render json: { error: @user.errors.full_messages.join(', ') }, status: :bad_request
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :phone_number, :password, :password_confirmation)
  end
end
