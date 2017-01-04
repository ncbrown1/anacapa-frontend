class UsersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :correct_user?, :except => [:index, :setup_org]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    client = session_octokit
    @memberships = client.org_memberships
  end

  def setup_org
    org_name = params[:org_name]
    client = session_octokit
    membership = client.org_membership(org_name)
    if membership.role != "admin"
      flash[:alert] = "You must be the owner of the organization that you are setting up"
      redirect_to user_path(session[:user_id])
    else
      client.update_org_membership(org_name, {
        role: 'admin',
        state: 'pending',
        user: ENV['MACHINE_USER_NAME']
      })
      machine = machine_octokit
      machine.update_org_membership(org_name, {
        state: 'active',
      })
      redirect_to user_path(session[:user_id]), :notice => 'Set up organization!'
    end
  end
end
