class Api::LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @locations = Location.all
    render json: @locations
  end
end
