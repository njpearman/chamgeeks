class SubscribersController < ApplicationController
  def create
    Subscriber.create subscriber_params
    redirect_to root_path, notice: "Thanks for subscribing!"
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
