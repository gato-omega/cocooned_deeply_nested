# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a default test list such that there's already something in the DB
# to see the effect of nested items when rendering all.

list = List.new(
  name: 'Test list A',
  items_attributes: [
    {
      name: 'AI1 (Item 1)',
      subitems_attributes: [
        {
          name: 'AI1S1 (Subitem 1-1)',
          microitems_attributes: [
            { name: 'AI1S1M1 (Microitem 1-1-1)' },
            { name: 'AI1S1M2 (Microitem 1-1-2)' },
          ]
        },
        {
          name: 'AI1S2 (Subitem 1-2)',
          microitems_attributes: [
            { name: 'AI1S2M1 (Microitem 1-2-1)' },
            { name: 'AI1S2M2 (Microitem 1-2-2)' },
          ]
        },
        {
          name: 'AI1S3 (Subitem 1-3)',
          microitems_attributes: [
            { name: 'AI1S3M1 (Microitem 1-3-1)' },
            { name: 'AI1S3M2 (Microitem 1-3-2)' },
          ]
        },
      ]
    },
    {
      name: 'AI2 (Item 2)',
      subitems_attributes: [
        {
          name: 'AI2S1 (Subitem 2-1)',
          microitems_attributes: [
            { name: 'AI2S1M1 (Microitem 2-1-1)' },
            { name: 'AI2S1M2 (Microitem 2-1-2)' },
          ]
        },
        {
          name: 'AI2S2 (Subitem 2-2)',
          microitems_attributes: [
            { name: 'AI2S2M1 (Microitem 2-2-1)' },
            { name: 'AI2S2M2 (Microitem 2-2-2)' },
          ]
        },
        {
          name: 'AI2S3 (Subitem 2-3)',
          microitems_attributes: [
            { name: 'AI2S3M1 (Microitem 2-3-1)' },
            { name: 'AI2S3M2 (Microitem 2-3-2)' },
          ]
        },
      ]
    },
    {
      name: 'AI3 (Item 3)',
      subitems_attributes: [
        {
          name: 'AI3S1 (Subitem 3-1)',
          microitems_attributes: [
            { name: 'AI3S1M1 (Microitem 3-1-1)' },
            { name: 'AI3S1M2 (Microitem 3-1-2)' },
          ]
        },
        {
          name: 'AI3S2 (Subitem 3-2)',
          microitems_attributes: [
            { name: 'AI3S2M1 (Microitem 3-2-1)' },
            { name: 'AI3S2M2 (Microitem 3-2-2)' },
          ]
        },
        {
          name: 'AI3S3 (Subitem 3-3)',
          microitems_attributes: [
            { name: 'AI3S3M1 (Microitem 3-3-1)' },
            { name: 'AI3S3M2 (Microitem 3-3-2)' },
          ]
        },
      ]
    },
  ]
)

list.save!
puts "Created test list `#{list.name}`."
