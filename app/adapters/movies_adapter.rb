require 'httparty'

class MoviesAdapter
    include HTTParty
    base_uri 'https://api.themoviedb.org/3/'

    def initialize
        @options = { 
            :query => { 'api_key': ENV['MOVIEDB_API_KEY'] },
            :headers => { 'Content-Type': 'application/json' }
        }
    end
    
    def search(search_query)
        @options[:query][:query] = search_query
        response = self.class.get('/search/movie', @options)
    end

    # def detail(id)
    #     self.class.get.('/movie/#{id}')
    # end

end