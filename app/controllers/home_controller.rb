class HomeController < ApplicationController

  def index
    render json: { links: []}
  end
end
