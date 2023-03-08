class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end


  def new
    @category = Category.new
  end


  def edit
    category
  end


  def create
      if @category.save
        format.html { redirect_to categories_url(@category), notice: "Category was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
  end


  def update

      if category.update(category_params)
        format.html { redirect_to categories_url(@category), notice: "Category was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
    end
  end


  def destroy
    category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url, notice: "Category was successfully destroyed." }
    end
  end

  private

    def category
      @category = Category.find(params[:id])
    end


    def category_params
      params.require(:category).permit(:name)
    end
end
