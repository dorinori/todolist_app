class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :todo_list_tags, id: false do |t|
    	t.belongs_to :todo_list
    	t.belongs_to :tags
    end
  end
end
