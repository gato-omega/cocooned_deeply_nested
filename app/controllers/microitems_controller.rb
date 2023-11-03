class MicroitemsController < ApplicationController
  before_action :set_microitem, only: %i[ show edit update destroy ]

  # GET /microitems or /microitems.json
  def index
    @microitems = Microitem.all
  end

  # GET /microitems/1 or /microitems/1.json
  def show
  end

  # GET /microitems/new
  def new
    @microitem = Microitem.new
  end

  # GET /microitems/1/edit
  def edit
  end

  # POST /microitems or /microitems.json
  def create
    @microitem = Microitem.new(microitem_params)

    respond_to do |format|
      if @microitem.save
        format.html { redirect_to microitem_url(@microitem), notice: "Microitem was successfully created." }
        format.json { render :show, status: :created, location: @microitem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @microitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microitems/1 or /microitems/1.json
  def update
    respond_to do |format|
      if @microitem.update(microitem_params)
        format.html { redirect_to microitem_url(@microitem), notice: "Microitem was successfully updated." }
        format.json { render :show, status: :ok, location: @microitem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @microitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microitems/1 or /microitems/1.json
  def destroy
    @microitem.destroy!

    respond_to do |format|
      format.html { redirect_to microitems_url, notice: "Microitem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_microitem
      @microitem = Microitem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def microitem_params
      params.require(:microitem).permit(:name, :subitem_id)
    end
end
