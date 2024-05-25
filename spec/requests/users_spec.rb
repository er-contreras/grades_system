require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:json_response) { JSON.parse(response.body) }
  let(:users) { create_list(:user, 4) }
  let(:user) { create(:user) }

  describe "GET /users" do
    it "shows all users" do
      users

      get users_path

      expect(response).to have_http_status(200)
      expect(json_response.count).to eq(4)
      expect(json_response).to match_json_schema("users")
    end
  end

  describe "POST /users" do
    it "make succesful request" do
      user_params = { user: { name: "Joe", email: "joe@email.com" } }

      post users_path, params: user_params
      
      expect(response.status).to eq(201)
      expect(json_response).to match_json_schema("user")
      expect(User.count).to eq(1)
      expect(User.last.name).to eq("Joe")
    end

    it "make a unsuccesful request" do
      user_params = {}

      post users_path, params: user_params

      expect(response.status).to eq(400)
    end
  end

  describe "DELETE /user/:id" do
    it "deletes a user" do
      delete user_path(user.id)

      expect(response.status).to eq(200)
      expect(json_response).to eq({"message"=>"User: #{user.id} was deleted"})
    end

    it "raises an error" do
      delete user_path(999)

      expect(response.status).to eq(404)
    end
  end
end
