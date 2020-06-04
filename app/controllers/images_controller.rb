class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @images = Image.order(created_at: :desc)
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:notice] = 'Image was saved successfully'
      redirect_to @image
    else
      flash[:alert] = 'Error found!'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.require(:image).permit(:name, :url)
  end
end
