class Api::V1::UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]


    def index
        render json: User.all.to_json
      end
  
      def profile
        render json: { user: UserSerializer.new(current_user) }, status: :accepted
      end
   
      def create
          @user = User.create(user_params)
          if @user.valid?
          @token = encode_token(user_id: @user.id)
          render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
          else
          render json: @user.errors.full_messages, status: :not_acceptable
          end
      end
      
      def retrieve_transactions
        transactions = @user.transactions
        transactions = transactions.sort_by{ |transaction| [transaction.created_at, transaction.updated_at].max }.reverse!
        render json: transactions.to_json
      end


      private
      def user_params
        params.require(:user).permit(:username, :password, :name)
      end


end
