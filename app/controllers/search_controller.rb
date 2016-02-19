class SearchController < ApplicationController
  def search
    puts params[:query]
  end
end
