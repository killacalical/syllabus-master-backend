class Api::V1::SyllabusesController < ApplicationController

    def index
        # instance variables arent' actually needed because JSON does not pass through view file. Maintaining the variable is not necessary.
        syllabuses = Syllabus.all
        # render json: @syllabuses
        # options = {
        #     #include associated category
        #     include: [:category]
        # }
        # renders as JSON format
        # render json: SyllabusSerializer.new(@syllabuses, options)
        # to add a relationship in serializer
        render json: SyllabusSerializer.new(syllabuses)
    end

    def create
        syllabus = Syllabus.new(syllabus_params)
        if syllabus.save
            render json: SyllabusSerializer.new(syllabus), status: :accepted
            # status tells user on front end that the data has been accepted
        else
            render json: {errors: syllabus.errors.full_messages}, status: :unprocessible_entity
        end
    end


    private

    def syllabus_params
        params.require(:syllabus).permit(:title, :description, :image_url, :category_id)
    end
end
