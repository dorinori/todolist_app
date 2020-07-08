class TodoListTag < ApplicationRecord
  belongs_to :todo_lists
  belongs_to :tags
end