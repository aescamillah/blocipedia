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
    @users = User.not_collaborators_or_owner(@wiki)
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
  end

  def update
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Deleted successfully."
      # redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      # render :show
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

end
