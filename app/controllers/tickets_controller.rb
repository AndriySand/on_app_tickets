class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :ticket_history,
                                    :take_responsibility, :change_status]
  before_action :authenticate_user!, only: [:index, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    status = params[:status]
    if status
      @tickets = Ticket.where(:status => status)
      @header = status.is_a?(Array) ? status.join(' and ') : status + ' tickets'
    elsif params[:search].present?
      @search = Ticket.search do
        fulltext params[:search]
      end
      @tickets = @search.results
    else
      @tickets = Ticket.all
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        UserMailer.welcome_email(@ticket).deliver
        format.html { redirect_to @ticket, notice: 'We received your query and answer you as soon as possible.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        @ticket.update_responsible(:status, 'Waiting for Staff Response')
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  def ticket_history
    edits = @ticket.versions.
      select{|vers| vers.changeset.has_key?('updated_at') && !vers.changeset.has_key?('id')}.
      map{|vers| vers.changeset}
    @results = []
    edits.each do |edit|
      date = edit.delete('updated_at').last.strftime('%d-%m-%Y %H:%M:%S')
      edit.each_pair{|key, val| @results << {:field => key, :from => val.first, :to => val.last, :date => date} }
    end
  end

  def take_responsibility
    user_id = params[:user_id].to_i
    if @ticket.manager_id == user_id
      update_responsible(:manager_id)
      responsib = 'refused take'
    else
      update_responsible(:manager_id, user_id)
      responsib = 'took'
    end
    render :text => "You #{responsib} responsibility for this ticket"
  end

  def change_status
    update_responsible(:status, params[:status])
    render :text => "Status changed successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = params[:id].present? ? find_ticket(:id) : find_ticket(:ticket_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:user_name, :user_email, :subject, :body, :status, :department)
    end

    def find_ticket(key)
      Ticket.find(params[key])
    end

    def update_responsible(key, value = nil)
      @ticket.update_attribute(key, value)
    end
end
