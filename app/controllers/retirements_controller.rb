class RetirementsController < ApplicationController
  def show
    @retirement = Retirement.find(params[:id])
  end

  def create
    @retirement = Retirement.new retirement_params
    if @retirement.save
      flash[:notice] = t('alerts.new_retirement')
      redirect_to retirement_url id: @retirement.hashid
    else
      render 'pages/home'
    end
  end

  private

    def retirement_params
      params.require(:retirement).permit(:name, :display_initials, :retirement_date)
    end

end
