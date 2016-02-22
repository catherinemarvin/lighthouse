class SearchController < ApplicationController
  def search
    search_query = params[:query]

    tmdb = ::TMDB.new

    response = tmdb.search_movie(search_query)
    @movies = response.parsed_response["results"]
  end
end
