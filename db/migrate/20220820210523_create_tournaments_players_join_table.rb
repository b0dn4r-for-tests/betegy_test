class CreateTournamentsPlayersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :tournaments, :players do |t|
      t.integer :place, limit: 2
      t.integer :points_qualification, null: false
      t.integer :prize_pool, null: false

      t.index :tournament_id
      t.index :player_id
    end
  end
end
