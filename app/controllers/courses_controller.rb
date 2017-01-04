class CoursesController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    @course_names = Course.all.map(&:name)
    client = session_octokit
    @memberships = client.org_memberships
  end

  # GET /courses/1/edit
  def edit
  end


  def create
    org_name = params[:org_name]
    client = session_octokit
    membership = client.org_membership(org_name)
    if membership.role != "admin"
      flash[:alert] = "You must be the owner of the organization that you are setting up"
      redirect_to new_course_path
    else
      add_machine_user_to_org(org_name)
      @course = Course.new(name: org_name)

      respond_to do |format|
        if @course.save
          format.html { redirect_to @course, notice: 'Course was successfully set up.' }
          format.json { render :show, status: :created, location: @course }
        else
          format.html { render :new, alert: 'There was an error creating your course.' }
          format.json { render json: @course.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :term, :description)
    end

    def add_machine_user_to_org(org_name)
      client = session_octokit
      client.update_org_membership(org_name, {
        role: 'admin',
        state: 'pending',
        user: ENV['MACHINE_USER_NAME']
      })
      machine = machine_octokit
      machine.update_org_membership(org_name, {
        state: 'active',
      })
    end
end
