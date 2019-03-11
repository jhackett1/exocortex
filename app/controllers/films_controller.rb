class FilmsController < ApplicationController
    before_action :authenticate_user!

    # List out all films
    def index
        @films = current_user.films.order("seen DESC")
        @new_film = current_user.films.new
    end

    # Process creation
    def create
        @film = current_user.films.build(film_params)
        if @film.save
            redirect_to root_path
        end
    end

    private

    def film_params
        params.require(:film).permit(:title, :seen)
    end

end