module Api
  module V1
    class AuthController < ApplicationController
      def register
        user = User.new(auth_params)

        if user.save
          token = JsonWebToken.encode(sub: user.id)
          render json: { token: token, user: { id: user.id, email: user.email } }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def login
        user = User.find_by(email: params.require(:email))

        if user&.authenticate(params.require(:password))
          token = JsonWebToken.encode(sub: user.id)
          render json: { token: token, user: { id: user.id, email: user.email } }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      private

      def auth_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
    end
  end
end
