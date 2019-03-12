class FilmsController < ApplicationController
    before_action :authenticate_user!

    # List out all films
    def index
        @films = current_user.films.order("seen DESC")
        @new_film = current_user.films.new
    end

    # Create new record
    def create
        @film = current_user.films.build(film_params)

        # puts film_params[:title]

        api = MoviesAdapter.new
        response = api.search(film_params[:title])
        film = response["results"][0]

        puts film["title"]
        puts film["poster_path"]
        puts film["overview"]

        

        if @film.save
            redirect_to root_path
        end
    end

    private

    def film_params
        params.require(:film).permit(:title, :seen)
    end

end