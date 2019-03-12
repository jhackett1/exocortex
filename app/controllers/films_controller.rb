class FilmsController < ApplicationController
    before_action :authenticate_user!

    # List out all films
    def index
        @films = current_user.films.order("seen DESC")
        @new_film = current_user.films.new
    end

    # Create new record
    def create
        @new_film = current_user.films.build(film_params)
        api = MoviesAdapter.new
        # Check if the title was actually given before doing this?
        response = api.search(film_params[:title])
        # Make sure that there is at least one result before doing this?
        if response.success?
            film_result = response["results"][0]
            @new_film[:official_title] = film_result["title"]
            @new_film[:official_overview] = film_result["overview"]
            @new_film[:poster] = film_result["poster_path"]
            if @new_film.save
                flash[:notice] = "Film added to list."
                redirect_to root_path
            else
                flash[:alert] = "That film could not be saved. Please try again."
                redirect_to root_path
            end
        else
            flash[:alert] = "Didn't find any results from that film. Try an alternative title?"
            redirect_to root_path
        end
    end

    private

    def film_params
        params.require(:film).permit(:title, :seen)
    end

end