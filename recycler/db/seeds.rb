# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

JSON.parse(File.read('../data/chicago-recycling-guide.json'))["data"].each do |item|
  material = Material.new

  material.name = item['Material']
  material.recyclable = item["Is Material accepted in Chicago's Blue Cart Program or at Recycling Drop-Off Centers?"] == 'Yes'

  if item['Alternative Recycling Outlet'] != 'NA'
    material.alternative_outlet = item['Alternative Recycling Outlet']
  end

  program_name = item['Mail or Drop-Off Program?']
  if program_name.match?(/\bdrop\soff\b/i)
    material.programs << Program.find_or_create_by!(name: :drop_off)
  end

  if program_name.match?(/\bmail\b/i)
    material.programs << Program.find_or_create_by!(name: :mail)
  end

  material.address = item['Address'] if item['Address'] != 'NA'
  material.phone = item['Phone'] if item['Phone'] != 'NA'
  material.url = item['Website'] if item['Website'] != 'NA'

  material.details = item['Details and/or Restrictions']
  material.save!
end
