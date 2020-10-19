require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it "validates the user" do
      @user = User.new(first_name: "Sam", :last_name => "Goodlad", :email => "sam@g.com", :password => "password123", :password_confirmation => "password123")
      @user.save!
      expect(@user).to be_instance_of(User)
    end

    it "validates that the passwords match" do
      @user = User.new(first_name: "Sam", :last_name => "Goodlad", :email => "sam@g.com", :password => "password123", :password_confirmation => "password12")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "validates the password" do
      @user = User.new(first_name: "Sam", :last_name => "Goodlad", :email => "sam@g.com", :password => nil, :password_confirmation => "password12")
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "validates the password_confirmation" do
      @user = User.new(first_name: "Sam", :last_name => "Goodlad", :email => "sam@g.com", :password => "password123", :password_confirmation => nil)
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "validates the user email uniqueness" do
      @user1 = User.new(first_name: "Sam", :last_name => "Goodlad", :email => "sam@g.com", :password => "password123", :password_confirmation => "password123")
      @user1.save!
      @user2 = User.new(first_name: "Sammy", :last_name => "Goodladson", :email => "sam@g.com", :password => "password123", :password_confirmation => "password123")
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it "validates the password length" do
      @user2 = User.new(first_name: "Sammy", :last_name => "Goodladson", :email => "sam@g.com", :password => "p123", :password_confirmation => "p123")
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Password is too short (minimum is 7 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it "checks the login and returns the authenticated user" do
      user = User.create(first_name: "Sammy", :last_name => "Goodladson", :email => "sam@g.com", :password => "password123", :password_confirmation => "password123")
      authenticated_user = User.authenticate_with_credentials("sam@g.com", "password123")
      expect(authenticated_user).to eq(user)
    end

    it "checks the user's email" do
      authenticated_user = User.authenticate_with_credentials("sam@g.com", "password123")
      expect(authenticated_user).to be(nil)
    end
    
    it "checks the email against the password in database" do
      user = User.create(first_name: "Sammy", :last_name => "Goodladson", :email => "sam@g.com", :password => "password123", :password_confirmation => "password123")
      authenticated_user = User.authenticate_with_credentials("sam@g.com", "password1")
      expect(authenticated_user).to eq(nil)
    end

  end
end
