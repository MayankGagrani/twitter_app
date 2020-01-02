module Api
  module V1
    class TweetsController < ApplicationController
      before_action :authenticate_user!
      # skip_before_action :verify_authenticity_token
      before_action :find_tweet , only: [:destroy]

      def follower_tweets
        if current_user.follower_relationships.present?
          tweets = current_user.follower_relationships.map{|a| User.find(a.follower_id)}.first.tweets.order('created_at DESC')
          if tweets.present?
            render json: {status: 200, tweets: tweets, message: "Tweets of all followers"}
          else
            render json: {status: 200, message: "No tweets"}
          end
        else
          render json: {status: 200, message: "No followers present"}
        end
      end

      def create
        @tweet = Tweet.new(tweet_params)
        if @tweet.save
          render json: {status: "success",message: "Tweet created successfully"}
        else
          render json: {status: "Error",message: @tweet.formatted_error}
        end
      end

      def destroy
        if @tweet.present? 
          if @tweet.destroy
            render json: {status: "success",message: "Tweet deleted successfully"}
          else
            render json: {status: "Error",message: @tweet.formatted_error}
          end
        else
          render json: {status: "Error",message: "This tweet is not present"}
        end
      end


      private
       def find_tweet
        @tweet = Tweet.find_by(id: params[:id])
       end
      
      def tweet_params
        params.require(:tweet).permit(:user_id, :content )
      end
    end
  end
end