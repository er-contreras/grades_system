require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    user = build_list(:user, 10)   
  end

  describe "GET /users" do
    it "shows all users" do
      get users_path
      expect(response).to have_http_status(200)
      p response.body
    end
  end
end
