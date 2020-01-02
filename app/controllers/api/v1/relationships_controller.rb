module Api
  module V1
    class RelationshipsController < ApplicationController
      before_action :authenticate_user!
      # skip_before_action :verify_authenticity_token

      def follow_user
        current_user.follow(params[:user_id])
        if current_user.errors.present?
        render json: {status: "error", message: current_user.errors.messages}
       else
        render json: {status: 200, message: "follow succesfully"}
       end
      end

      def unfollow_user  
        current_user.unfollow(params[:user_id])
       if current_user.errors.present?
        render json: {status: "error", message: current_user.errors.messages}
       else
        render json: {status: 200, message: "unfollow succesfully"}
       end
      end
      
    end
  end
end