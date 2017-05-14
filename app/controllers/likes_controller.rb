class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @ideas = user.liked_ideas
    render 'ideas/index'
  end

  def create
    idea = Idea.find(params[:idea_id])

    if cannot? :like, idea
     redirect_to(
       idea_path(idea),
       alert: 'Liking your own idea is disgusting 🤢'
     )
     return # early return to prevent execution of anything
     # after the redirect above
   end

    like = Like.new(user: current_user, idea: idea)
    if like.save
      redirect_to idea_path(idea), notice: 'Liked question! 💖'
    else
      redirect_to idea_path(idea), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    like = Like.find(params[:id])
    
    if cannot? :like, like.idea
     redirect_to(
       idea_path(idea),
       alert: 'Un-liking your own idea is prepostrous 🤢'
     )
     return
   end

    if like.destroy
      redirect_to idea_path(like.idea), notice: 'Un-liked question! 💔'
    else
      redirect_to idea_path(like.idea), alert: like.errors.full_messages.join(', ')
    end
  end

end
