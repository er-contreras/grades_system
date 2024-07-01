class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded = jwt_decode(header)

    @current_user = decoded ? User.find(decoded[:user_id]) : nil

    head :unauthorized unless @current_user
  end
end
