class UsersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index, :setup_org]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
