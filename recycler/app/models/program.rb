class Program < ApplicationRecord
  has_many :program_materials
  has_many :materials, through: :program_materials
end
