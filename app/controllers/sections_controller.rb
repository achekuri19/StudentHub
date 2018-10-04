class SectionsController < ApplicationController
  before_action -> {logged_in?}

  def show
    @section = Section.find(params[:id])
  end
  def index
    @sections = Section.all
  end
  def new
    @section = current_user.sections.build
  end
  def edit
    @section = Section.find(params[:id])
  end
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:success] = "Profile updated"
      redirect_to @section
    else
      render 'edit'
    end
  end
  def destroy
    Section.find(params[:id]).destroy
    flash[:success] = "Section Deleted"
    redirect_to sections_url
  end
  private
    def section_params
      params.require(:name).permit(:description, :location)
    end
end
