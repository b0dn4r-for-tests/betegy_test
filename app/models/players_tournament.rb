class PlayersTournament < ApplicationRecord
  belongs_to :player
  belongs_to :tournament

  delegate :full_name, to: :player

  validates :points_qualification, :prize_pool, presence: true
end
