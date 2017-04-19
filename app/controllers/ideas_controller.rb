class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @idea = Idea.new
  end

  def create
     @idea = Idea.new(idea_params)
     @idea.user = current_user
     if @idea.save
     redirect_to ideas_path, notice: "Idea Created"
    else
     render :new
    end
  end

  def index
    # @ideas = Idea.all
    @ideas = Idea.order('created_at DESC').last(20)
  end

  def show
    @review = Review.new
  end

  def edit
    redirect_to root_path, alert: "access defined" unless can? :edit, @idea
  end

  def update
    redirect_to root_path, alert: "access defined" unless can? :update, @idea
    if @idea.update idea_params
      redirect_to @idea, notice: "Idea Updated"
    else
      render :edit
    end
  end

  def destroy
      redirect_to root_path, alert: "access defined" unless can? :destroy, @idea
      @idea.destroy
      redirect_to ideas_path, notice: "Idea Deleted"
  end





  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end


end
