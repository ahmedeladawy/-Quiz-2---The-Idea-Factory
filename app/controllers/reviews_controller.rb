class ReviewsController < ApplicationController
  before_action :find_idea, only: [:create, :edit, :update, :destroy]

  def create
    @idea          = Idea.find params[:idea_id]
    review_params = params.require(:review).permit(:body)
    @review       = Review.new review_params
    @review.idea  = @idea
    @review.user = current_user
    if @review.save review_params
      redirect_to idea_path(@idea), notice: "Review created"
    else
      render "/ideas/show"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @idea = Idea.find(params[:idea_id])
  end


  def update
     @idea = Idea.find(params[:idea_id])
     @review = Review.find(params[:id])
     @review.update review_params
     redirect_to @idea , notice: 'Review Updated'
   end

   def destroy
     @review = @idea.reviews.find(params[:id])
     @review.destroy
     redirect_to @idea , notice: "Review Deleted"
   end

  private
  def review_params
    params.require(:review).permit(:body)
  end

  def find_idea
    @idea = Idea.find(params[:idea_id])
end

end
