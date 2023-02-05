class Api::V1::ContentsController < ApplicationController
  before_action :authorized
  before_action :is_project_owner?, only: %i[create destroy update]
  before_action :set_content, only: %i[show update destroy]
  # GET /contents
  def index
    @contents = Content.all

    render json: @contents
  end

  # GET /contents/1
  def show
    render json: @content
  end

  # POST /contents
  def create
    @content = Content.new(content_params)

    if @content.save
      render json: @content, status: :created, location: @content
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contents/1
  def update
    if @content.update(content_params)
      render json: @content
    else
      render json: @content.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contents/1
  def destroy
    @content.destroy
    render json: { message: 'Deleted successfully' }, status: :ok
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find(params[:id])
    end

    def is_project_owner?
      return true if @content.project.user_id == current_user.id
    rescue StandardError => error
      render json: { message: 'Only Owner of the Project is authorized to this action' }, status: 404
    end

    # Only allow a list of trusted parameters through.
    def content_params
      params.require(:content).permit(:title, :body, :project_id)
    end
end
