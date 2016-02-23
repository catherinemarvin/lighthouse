class SearchController < ApplicationController
  def search
    search_query = params[:query]

    tmdb = ::TMDB.new

    response = tmdb.search_movie(search_query)

    raw_movies = response.parsed_response["results"]
    @movies = raw_movies.map do |movie|
      film = Movie.find_or_initialize_by(tmdb_id: movie["id"])
      film.title = movie["original_title"]
      film.description = movie["overview"]
      film
    end

    ActiveRecord::Base.transaction do
      @movies.each do |movie|
        movie.save
      end
    end
  end
end
