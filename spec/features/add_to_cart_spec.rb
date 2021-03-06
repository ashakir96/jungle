require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "users can add to cart and see the product in checkout" do
    # ACT
    visit root_path
    expect(page).to have_content("My Cart (0)")

    first("article.product").find_button("Add").click

    expect(page).to have_content("My Cart (1)")
    
    find_link("My Cart (1)").click
    # VERIFY
    expect(page).to have_content "TOTAL:"
    page.save_screenshot
  end
end
