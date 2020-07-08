class TodoList < ApplicationRecord
	has_many :todo_items
	has_and_belongs_to_many :tags
end
