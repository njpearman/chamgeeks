class SubscribersController < ApplicationController
  def create
    Subscriber.create subscriber_params
    flash[:info] = "Thanks for subscribing!"
    redirect_to root_path
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
