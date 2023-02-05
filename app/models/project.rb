class Project < ApplicationRecord
  belongs_to :user
  has_one :content
  self.inheritance_column = :project_type
  enum type: { in_house: 0, external: 1, international: 2 }
end
