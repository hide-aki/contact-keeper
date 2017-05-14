require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
  describe 'GET /api/v1/users' do
    it 'returns a response for the index action' do
      get :index
      res_body = JSON.parse(response.body)

      expect(res_body['msg']).to eq('Nothing to see here.')
    end
  end

  describe 'POST /api/v1/users' do
    it 'creates a new user if fields are valid' do
      post :create, params: {
        user: {
          first_name: 'Test_firstname',
          last_name: 'Test_lastname',
          username: 'Test_username',
          email: 'test@test.com',
          phone_number: '123-456-7890',
          password: 'password',
          password_confirmation: 'password'
        }
      }


      res_body = JSON.parse(response.body)
      user = User.first

      expect(response.status).to eq(200)
      expect(res_body['username']).to eq('Test_username')
      expect(res_body['first_name']).to eq('Test_firstname')
      expect(user.first_name).to eq('Test_firstname')
    end
  end

  describe 'PUT /api/v1/users' do
    let(:user) { FactoryGirl.build(:user) }

    it 'modifies user details successfully' do
      pw = user.password
      user.save
      post :login, params: { email: user.email, password: pw }
      res_body = JSON.parse(response.body)
      token = res_body['auth_token']

      @request.headers['Authorization'] = "Bearer #{token}"
      put :update, params: { id: user.id, user: { first_name: 'NewName' } }

      second_res = JSON.parse(response.body)
      modified_user = User.first

      expect(modified_user.first_name).to eq('NewName')
    end
  end

  describe 'DELETE /api/v1/users' do
    xit 'successfully deletes the user' do

    end
  end
end
