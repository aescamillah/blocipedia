class CollaboratorsController < ApplicationController

  def index
    @users = User.all
    @wiki = Wiki.find(params[:wiki_id])
    # @collaborators = Collaborator.belonging_to(Wiki.find(params[:wiki_id]))
    @collaborators = @wiki.users
  end

  def show
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @users = User.not_owner(@wiki)
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    # authorize @wiki
    @collaborator = Collaborator.new(params.permit(:user_id, :wiki_id))
    if @collaborator.save
      flash[:notice] = "Collaborator was saved."
      redirect_to wiki_collaborators_path(@wiki)
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

end
