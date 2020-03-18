class PinsController < ApplicationController
  def index
    @pins = Pin.near([current_user.latitude, current_user.longitude], 0.10)
    @user_marker =
      {
        lat: current_user.latitude,
        lng: current_user.longitude,
        image_url: helpers.asset_url("mark.png")
      }

    @markers = @pins.map do |pin|
      {
        lat: pin.latitude,
        lng: pin.longitude,
        image_url: helpers.asset_url("pin.png"),
        infoWindow: render_to_string(partial: "info_window", locals: { pin: pin })
      }
    end
  end

  def create
    @pin = Pin.new(pin_params)
    @pin.user_id = current_user.id
    if @pin.save
      redirect_to pin_path(@pin)
    else
      render "pin"
    end
  end

  def new
    @pin = Pin.new
    @comment = Comment.new
    @vote = Vote.new
  end


  def destroy
    @pin = Pin.find(params[:id])
    @pin.destroy
    redirect_to pins_path
  end

  def show
    @pin = Pin.find(params[:id])
    @comment = Comment.new
    @vote = Vote.new
  end

  private

  def pin_params
    params.require(:pin).permit(:title, :description, :user_id, :address, :address, :photo)
  end
end
