class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show edit update destroy ]

  def index
    @properties = Property.all
  end

  def show
    @station = @property.stations
  end

  def new
    @property = Property.new
    2.times { @property.stations.build }
  end

  def edit
    @property.stations.build
  end

  def create
    @property = Property.new(property_params)
    if params[:back]
      render :new
    else
      if @property.save
        redirect_to properties_path, notice: "投稿を作成しました"
      else
        render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: "物件情報を編集しました" }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: "物件情報を削除しました" }
      format.json { head :no_content }
    end
  end

  private
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:name, :price, :address, :year, :memo, stations_attributes: [:id, :line, :station_name, :minute])
    end
end
