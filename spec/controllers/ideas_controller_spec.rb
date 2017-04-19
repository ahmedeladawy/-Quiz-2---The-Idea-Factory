require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:idea)  { FactoryGirl.create(:idea, { user: user }) }
  let(:idea1) { FactoryGirl.create(:idea) }

# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
describe '#new' do
    context 'with no user signed in' do
      it 'redirects the user to the home page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user signed in' do
      before { request.session[:user_id] = user.id }

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end

      it 'assigns a new Idea instance variable' do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end
end

# >>>>>>>>>>>>>>>>>>>>>>>>>>>
  describe '#create' do
    context 'with no signed in user' do
        it 'redirects to the home page' do
          post :create
          expect(response).to redirect_to(new_session_path)
        end
    end

    context 'with signed in user' do
      before { request.session[:user_id] = user.id }

      context 'with valid attributes' do
        def valid_request
          post :create, params: {
                          idea: FactoryGirl.attributes_for(:idea)
                        }
        end

        it 'creates a new Idea in the database' do
          count_before = Idea.count
          valid_request
          count_after = Idea.count
          expect(count_after).to eq(count_before + 1)
        end
        it 'redirects to the idea show page' do
          valid_request
          expect(response).to redirect_to(ideas_path)
        end
        it 'associates the created idea with the sigend in user' do
        valid_request
        expect(Idea.last.user).to eq(user)
      end
      end
    end
  end




end
