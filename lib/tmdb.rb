require 'httparty'

class TMDB
  include HTTParty
  base_uri "https://api.themoviedb.org/3"

  def initialize()
    @api_key = Figaro.env.tmdb_key
  end

  def search_movie(movie_title)
    options = {
      query: {
        query: movie_title,
        api_key: @api_key
      }
    }
    self.class.get("/search/movie", options)
  end
end
