class GradesController < ApplicationController
  def index
    @grades = Grade.all

    render json: @grades
  end

  def create
    @grade = Grade.new(grade_params)

    if @grade.save
      render json: @grade, status: :ok
    else
      render json: { errors: @grade.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @grade = Grade.find(params[:id])

    if @grade.update(grade_params)
      render json: { message: "Grade #{@grade.id} has been updated" }, status: :ok
    else
      render json: { errors: @grade.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def grade_params
    params.require(:grade).permit(:grade, :quarter, :user_id, :course_id)
  end
end
