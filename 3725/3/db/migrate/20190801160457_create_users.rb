# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
# :reek:TooManyStatements
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_hash, null: false

      t.timestamps
    end
  end
end
