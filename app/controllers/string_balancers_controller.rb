class StringBalancersController < ApplicationController
  def new
  end

  def create
    result = VerifyStringBalancer.call(prompt: string_balancer_params[:prompt])

    if result.success?
      render turbo_stream: turbo_stream.update("result", result.message),
        status: :accepted
    else
      render turbo_stream: turbo_stream.update("result", result.message),
        status: :unprocessable_entity
    end
  end

  private

  def string_balancer_params
    params.require(:string_balancer).permit(:prompt)
  end
end
