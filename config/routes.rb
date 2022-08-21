Rails.application.routes.draw do
  namespace :poker do
    get 'assets/leaderboard/:tournament_id', to: 'assets#leaderboard'
  end
end
