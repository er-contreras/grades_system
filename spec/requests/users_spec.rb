require 'rails_helper'

RSpec.describe "Users", type: :request do
  include JsonWebToken

  let(:json_response) { JSON.parse(response.body) }
  let(:users) { create_list(:user, 4) }
  let(:current_user) { users.first }
  let(:valid_token) { jwt_encode(user_id: current_user.id) }
  let(:headers) { { "Authorization" => "Bearer #{valid_token}" } }

  before do
    users
  end

  describe "GET /users" do
    it "shows all users" do
      get users_path, headers: headers

      expect(response).to have_http_status(200)
      expect(json_response.count).to eq(4)
      expect(json_response).to match_json_schema("users")
    end

    it "return unproccessable entity" do
      get users_path

      expect(response).to have_http_status(401)
    end
  end

  describe "GET /user/:id" do
    it "return user by id" do
      get user_path(users.first.id), headers: headers

      expect(response.status).to eq(200)
    end
  end

  describe "POST /users" do
    it "make succesful request" do
      user_params = { user: { name: "Joe", email: "joe@email.com" } }

      post users_path, params: user_params, headers: headers
      
      expect(response.status).to eq(201)
      expect(json_response).to match_json_schema("user")
      expect(User.count).to eq(users.length + 1)
      expect(User.last.name).to eq("Joe")
    end

    it "make a unsuccesful request" do
      user_params = {}

      post users_path, params: user_params

      expect(response.status).to eq(400)
    end
  end

  describe "PUT /user/:id" do
    it "update user" do
      user = users.last
      user_params = { user: { name: "x name" } }

      put user_path(user.id), params: user_params, headers: headers

      expect(response.status).to eq(200)
      expect(json_response).to  match_json_schema("user")
    end

    it "cannot be updated" do
      user_new_params = { user: { name: "any name" } }

    end
  end

  describe "DELETE /user/:id" do
    it "deletes a user" do
      user = users.last

      delete user_path(user.id), headers: headers

      expect(response.status).to eq(200)
      expect(json_response).to eq({"message"=>"User: #{user.id} was deleted"})
    end

    it "raises an error" do
      delete user_path(999)

      expect(response.status).to eq(401)
    end
  end
end
