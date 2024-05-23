class CoursesController < ApplicationController
  before_action :find_course, only: %i[show update destroy]

  def index
    @courses = Course.all

    render json: @courses
  end

  def show
    render json: @course
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      render json: @course, status: :created
    else
      render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      render json: @course, status: :ok
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @course.destroy
      render json: { message: "Course #{@course.id} has been destroy" }, status: :ok
    else
      render json: { errors: @course.errors.full_messages }
    end
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end

  def find_course
    @course = Course.find(params[:id])
  end
end
