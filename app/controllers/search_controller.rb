class SearchController < ApplicationController
  def search
    search_query = params[:query]

    tmdb = ::TMDB.new

    response = tmdb.search_movie(search_query)
    @movies = response.parsed_response["results"]

    ActiveRecord::Base.transaction do 
      @movies.each do |movie|
        film = Movie.find_or_initialize_by(tmdb_id: movie["id"])
        film.title = movie["original_title"]
        film.description = movie["overview"]
        film.save
      end
    end
  end
end
