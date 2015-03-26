class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_auth, only:[:show]

  def check_auth
    unless user_signed_in?
      redirect_to :controller => :users
    end
  end

  def show
  end

  def index
  end

end
