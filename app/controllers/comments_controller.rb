class CommentsController < ApplicationController
  def create
    @pin = Pin.find(params[:pin_id])
    @comment = Comment.new(comment_params)
    @comment.pin = @pin

    @comment.user = current_user
    if @comment.save

      redirect_to pin_path(@pin)
    else

      render "pins/show"
    end
    authorize @comment
  end

  def new
    @comment = Comment.new
    authorize @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to pin_path(@comment.pin)
    authorize @comment
  end

  def edit
  end

  def update
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :pin, :user)
  end
end
