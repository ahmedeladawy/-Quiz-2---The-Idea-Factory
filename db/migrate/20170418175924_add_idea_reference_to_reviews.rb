class AddIdeaReferenceToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :idea, foreign_key: true
  end
end
