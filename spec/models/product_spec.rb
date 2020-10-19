require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "validates the product" do
      @category = Category.new(:name => "Sports")
      @product = Product.new(:name => "Football", :price => 3000, :quantity => 30, :category => @category)
      @product.save!
      expect(@product.id).to be_present
    end

    it "validates the name" do
      @category = Category.new(:name => "Goods")
      @product = Product.new(:name => nil, :price => 3000, :quantity => 23, :category => @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "validates the price" do
      @category = Category.new(:name => "Sports")
      @product = Product.new(:name => "Things2", :price => nil, :quantity => 30, :category => @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Price cents is not a number", "Price is not a number", "Price can't be blank")
    end

    it "validates the quantity" do
      @category = Category.new(:name => "Goods")
      @product = Product.new(:name => "Stuff", :price => 3000, :quantity => nil, :category => @category)
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates the category" do
      @product = Product.new(:name => "Thing", :price => 3000, :quantity => 23, :category => nil)
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
