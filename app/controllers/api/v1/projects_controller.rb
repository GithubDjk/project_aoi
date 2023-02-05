# app/controllers/api/v1/projects_controller.rb
class Api::V1::ProjectsController < ApplicationController
  before_action :project_params, only: %w[:create :update]
  before_action :authorized
  def index
    @projects = Project.all
    render json: @projects, status: :ok
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: { message: 'Project created successfully.' }, status: :created
    else
      render json: { errors: @project.errors }, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find(params[:id])
    render json: @project, status: :ok
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    render json: { message: 'Deleted successfully' }, status: :ok
  end

  def my_projects
    @projects = current_user.projects
    render json: @projects, status: :ok
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :type, :location, :thumbnail).merge(user_id: current_user.id)
  end
end
