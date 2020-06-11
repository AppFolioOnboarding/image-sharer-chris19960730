class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def index
    @tag = tag_params[:tag]
    if @tag
      @images = Image.tagged_with([@tag], any: true).order(created_at: :desc)
      process_filtered_image
    else
      @images = Image.order(created_at: :desc)
    end
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

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = 'Image was deleted successfully'
    redirect_to images_path
  end

  private

  def image_params
    params.require(:image).permit(:name, :url, :tag_list)
  end

  def process_filtered_image
    if @images.any?
      flash[:notice] = "Now only showing images with #{@tag} tag"
    else
      flash[:alert] = 'There is no such tag in our system'
      redirect_to images_path, status: :not_found
    end
  end

  def tag_params
    params.permit(:tag)
  end
end
