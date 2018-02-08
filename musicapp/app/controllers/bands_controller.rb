class BandsController < ApplicationController
  
  def index 
    render :index 
  end 
  
  def show 
    @band = Band.find(params[:id])
    render :show 
  end 
  
  def new 
    render :new
  end 
  
  def create 
    band = Band.new(band_params)
    if band.save 
      redirect_to bands_url 
    else 
      redirect_to new_band_url 
    end 
  end 
  
  
  
  private 
  
  def band_params
  params.require(:band).permit(:name)
  end 
  
end 