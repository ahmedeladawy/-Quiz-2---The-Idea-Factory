require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

  describe '#new' do
    it 'assigns an instance variable' do
     get :new
     expect(assigns(:idea)).to be_a_new(Idea)
    end
    it 'render a new template' do
      get :new
      expect(response).to render_template(:new)
    end
 end

 describe '#create' do
   context 'Valid parameter' do
     def valid_request
         post :create, params: {
                        idea: FactoryGirl.attributes_for(:idea)
                      }
      end
      it "create an idea in the database" do
        count_before = Idea.count
        valid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before + 1)
      end
      it "redirects to the home page" do
         valid_request
         expect(response).to redirect_to(ideas_path)
      end
   end
   context " invalid parameter" do
         def invaild_request
           post :create, params: {
                          idea: FactoryGirl.attributes_for(:idea,
                                                               title: nil)}
         end
         it "doesn't create new idea in the database" do
           count_before = Idea.count
           invaild_request
           count_after = Idea.count
           expect(count_after).to eq(count_before)
         end
         it "render back to the new template" do
           invaild_request
           expect(response).to render_template(:new)
         end

       end
     end

   end
