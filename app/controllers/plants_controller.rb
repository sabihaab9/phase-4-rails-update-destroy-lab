class PlantsController < ApplicationController

  # UPDATE /plants
  def update 
    plant = find_plant
    plant.update(plant_params)
    render json: plant

  rescue ActiveRecord
    ::RecordNotFound
    render_not_found_response
  end

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  #DELETE /plants

  def destroy
    #plant = plant.find_by(id: params[:id])
    plant = find_plant
    plant.destroy
    head :no_content
    rescue ActiveRecord::RecordNotFound
      #render json: { error: "plant not found" }, status: :not_found
      render_not_found_response
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  def render_not_found_response
    render json: {error: "Plant not found"}, status: :not_found
  end

  def find_plant
    Plant.find(params[:id])
  end

end
