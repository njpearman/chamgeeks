class MembershipsController < ApplicationController
  def new
    year_of_membership = (Time.now + 1.month).year
    @membership = Membership.new amount: 1000, year: year_of_membership
  end

  def create
    Membership.create membership_params
    redirect_to root_path, notice: 'Thanks for joining as a member!'
  end

  private

  def membership_params
    params.require(:membership).permit(:email, :name, :payment_ref, :year)
  end
end
