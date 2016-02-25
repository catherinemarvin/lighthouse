require 'httparty'

class TMDB
  include HTTParty
  base_uri "https://api.themoviedb.org/3"

  def initialize()
    @api_key = Figaro.env.tmdb_key

    config_info = configuration()
    image_info = config_info["images"]
    @base_image_url = image_info["base_url"]
    @backdrop_sizes = image_info["backdrop_sizes"]
    @poster_sizes = image_info["poster_sizes"]
  end

  def configuration
    options = {
      query: {
        api_key: @api_key
      }
    }
    self.class.get("/configuration", options)
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
