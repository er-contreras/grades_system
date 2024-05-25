require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:json_response) { JSON.parse(response.body) }

  before do
    @user = create_list(:user, 4)
  end

  describe "GET /users" do
    it "shows all users" do
      get users_path

      expect(response).to have_http_status(200)
      expect(json_response.count).to eq(4)
      expect(json_response).to match_json_schema("users")
    end
  end
end
