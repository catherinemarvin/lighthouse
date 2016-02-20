class SearchController < ApplicationController
  def search
    search_query = params[:query]

    tmdb = ::TMDB.new

    puts tmdb.search_movie(search_query)

  end
end
