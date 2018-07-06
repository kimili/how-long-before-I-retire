class PagesController < ApplicationController
  def home
    @retirement = Retirement.new
  end
end
