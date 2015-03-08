class RepliesController < ApplicationController
  before_filter :authenticate_user!

  def create
  	@ticket = Ticket.find(params[:ticket_id])
    reply = @ticket.replies.create(reply_params)

    respond_to do |format|
      if reply.save
        @ticket.update_attribute(:status, 'Waiting for Customer')
        UserMailer.answer(@ticket).deliver
        format.html { redirect_to @ticket, notice: 'Your answer has been sent to customer.' }
      else
        format.html { redirect_to @ticket, notice: 'You did not fill body.' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:body, :author_id)
    end

end
