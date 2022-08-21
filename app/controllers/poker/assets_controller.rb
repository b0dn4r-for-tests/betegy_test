class Poker::AssetsController < ApplicationController
  def leaderboard
    @tournament = Tournament.find_by(number: permit_params[:tournament_id])
  end

  private

  def permit_params
    params.permit(:tournament_id)
  end
end
