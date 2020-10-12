class HomeController < ApplicationController
  def index
    hash = RawgService.new
    @games = hash.get_games
    # @next_page = hash.next_page
    @popular_games = hash.most_popular_games
  end
end
