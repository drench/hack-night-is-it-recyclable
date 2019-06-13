class Material < ApplicationRecord
  has_many :program_materials
  has_many :programs, through: :program_materials
end
