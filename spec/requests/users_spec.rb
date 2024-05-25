require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:json_response) { JSON.parse(response.body) }

  before do
    @users = create_list(:user, 4)
  end

  describe "GET /users" do
    it "shows all users" do
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
    end
  end
end
