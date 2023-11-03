class SubitemsController < ApplicationController
  before_action :set_subitem, only: %i[ show edit update destroy ]

  # GET /subitems or /subitems.json
  def index
    @subitems = Subitem.all
  end

  # GET /subitems/1 or /subitems/1.json
  def show
  end

  # GET /subitems/new
  def new
    @subitem = Subitem.new
  end

  # GET /subitems/1/edit
  def edit
  end

  # POST /subitems or /subitems.json
  def create
    @subitem = Subitem.new(subitem_params)

    respond_to do |format|
      if @subitem.save
        format.html { redirect_to subitem_url(@subitem), notice: "Subitem was successfully created." }
        format.json { render :show, status: :created, location: @subitem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subitems/1 or /subitems/1.json
  def update
    respond_to do |format|
      if @subitem.update(subitem_params)
        format.html { redirect_to subitem_url(@subitem), notice: "Subitem was successfully updated." }
        format.json { render :show, status: :ok, location: @subitem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subitems/1 or /subitems/1.json
  def destroy
    @subitem.destroy!

    respond_to do |format|
      format.html { redirect_to subitems_url, notice: "Subitem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subitem
      @subitem = Subitem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subitem_params
      params.require(:subitem).permit(:name, :item_id)
    end
end
