class AddLanguageToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :language, :string
  end

  def self.down
    remove_column :notes, :language
  end
end