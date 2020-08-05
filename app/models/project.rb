class Project < ApplicationRecord
  enum type: {'A': 0, 'B': 1, 'C': 2}
  validates :name, uniqueness: true, presence: true
end
