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

        api = MoviesAdapter.new
        response = api.search(film_params[:title])
        film_result = response["results"][0]

        @film[:official_title] = film_result["title"]
        @film[:official_overview] = film_result["overview"]
        @film[:poster] = film_result["poster_path"]

        if @film.save
            redirect_to root_path
        end
    end

    private

    def film_params
        params.require(:film).permit(:title, :seen)
    end

end