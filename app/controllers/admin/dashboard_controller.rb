class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['AUTH_USER'], password: ENV['AUTH_PASSWORD'], if: -> { ENV["AUTH_PASSWORD"].present?}
  def show
  end
end
