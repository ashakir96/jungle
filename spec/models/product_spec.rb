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
      expect(@product.errors.full_messages)
    end

    it "validates the price" do
      @category = Category.new(:name => "Sports")
      @product = Product.new(:name => "Things2", :price => nil, :quantity => 30, :category => @category)
      expect(@product.errors.full_messages)
    end

    it "validates the quantity" do
      @category = Category.new(:name => "Goods")
      @product = Product.new(:name => "Stuff", :price => 3000, :quantity => nil, :category => @category)
      expect(@product.errors.full_messages)
    end

    it "validates the category" do
      @product = Product.new(:name => "Thing", :price => 3000, :quantity => 23, :category => nil)
      expect(@product.errors.full_messages)
    end

  end
end
