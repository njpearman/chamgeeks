class MembershipsController < ApplicationController
  def new
  end

  def create
    redirect_to root_path, notice: 'Thanks for joining as a member!'
  end
end
