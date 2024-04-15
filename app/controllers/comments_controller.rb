class CommentsController < ApplicationController
    before_action :set_feature
  
    def create

      if comment_params[:body].blank?
        render json: { error: "Comment body cannot be empty." }, status: :bad_request
        return
      end

      @comment = @feature.comments.new(comment_params)

      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_feature
      @feature = Feature.find(params[:feature_id])
    end
  
    def comment_params
      params.permit(:body)
    end
  end
  