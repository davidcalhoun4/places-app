class Api::PlacesController < ApplicationController

  def index
    @places = Place.all 
    render "index.json.jb"
  end

  def create
    @places = Place.new(
      name: params[:name],
      address: params[:address],
      image: params[:image_url]
    )
    if @places.save
      render "show.json.jb"
    else 
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update 
    place_id = params[:id]
    @places = Place.find_by(id: place_id)

    @places.name = params[:name] || @places.name
    @places.address = params[:address] || @places.address
    @places.image_url = params[:image_url] || @places.image_url

    if @places.save
      render "show.json.jb"
    else 
      render json: { errors: @places.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    place = Place.find_by(id: params[:id])
    place.destroy

    render json: {message: "you have destroyed this product!"}
  end

end
