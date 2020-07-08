class Tag < ApplicationRecord
  has_and_belongs_to_many :todo_lists
end
