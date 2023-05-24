class InstructorsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
        render json: Instructor.all
    end

    def show
        # render json: @instructor 
        instructor = Instructor.find(params[:id])
        render json: instructor
    end

    def update
        instructor = Instructor.find(params[:id])
        instructor.update!(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy 
        instructor = Instructor.find(params[:id])
        instructor.destroy
        head :no_content
    end

    def create 
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end




    private 

    def render_not_found_response
        render json: { error: "Instructor not found" }, status: :not_found
      end

         # POST error
    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def instructor_params
        params.permit(:name)
    end



    def one_instructor
        @instructor = Instructor.find(params[:id])
    end

end
