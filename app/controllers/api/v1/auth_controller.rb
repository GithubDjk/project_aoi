# app/controllers/api/v1/user_controller.rb

class Api::V1::AuthController < ApplicationController
  def signup
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user, jwt: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def signin
    user = User.find_by_email(user_params[:email])
    if user&.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user, jwt: token }, status: :ok
    else
      render json: { errors: ["Invalid email or password"] }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :country)
  end
end
