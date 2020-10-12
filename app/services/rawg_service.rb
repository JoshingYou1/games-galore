class RawgService
  include ApplicationHelper
  # Max results per page is 40
  def games_url
    "https://api.rawg.io/api/games"
  end

  def get_json_response(url)
    response = HTTP.get(url)
    JSON.parse(response)
  end

  def get_games
    get_json_response("#{games_url}?page_size=40")
  end

  def next_page
    get_json_response("#{games_url}#{["next"]}&page_size=40")
  end

  def previous_page
    get_json_response("#{games_url}#{["prev"]}&page_size=40")
  end

  def most_popular_games
    get_json_response("#{games_url}?dates=2019-01-01,#{current_date}&ordering=-added")
  end
end