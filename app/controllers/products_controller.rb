class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    redirect_to casino_path(casino_params)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @casino = Casino.find(casino_params)
    @product = Product.new(casino_id: @casino[:id])
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product[:casino_id] = params[:casino_id]

    respond_to do |format|
      if @product.save
        flash[:success] = "Producto creado exitosamente."
        format.html { redirect_to casino_path(casino_params) }
        format.json { render :show, status: :created, location: @product }
      else
        flash[:danger] = "Error en la creacion del producto"
        format.html { redirect_to new_casino_product_path }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        flash[:success] = "Producto editado exitosamente."
        format.html { redirect_to casino_product_path }
        format.json { render :show, status: :ok, location: @product }
      else
        flash.now[:danger] = "Error en la edicion del producto"
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      flash[:success] = "Producto eliminado exitosamente."
      format.html { redirect_to casino_path(casino_params) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :casino_id)
    end

    def casino_params
      params.require(:casino_id)
    end
end
