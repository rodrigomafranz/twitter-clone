class MessagesController < ApplicationController
  before_action :set_message, only:   %i[edit update destroy]
  before_action :authorize
  before_action :permission?, except: %i[new create retweet]

  # GET /messages/new
  def new
    redirect_to root_path
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to root_path, notice: "Message was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to root_path, notice: "Message was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to root_path, notice: "Message was successfully destroyed.", status: :see_other
  end

  # POST /messages/1/retweet
  def retweet
    message = Message.find(params[:message_id])
    message.retweet(current_user)

    redirect_to root_path, notice: "Thanks for retweeting!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:user_id, :text, :image).merge(user_id: current_user.id)
    end

    def permission?
    redirect_to logout_path unless current_user == @message.user
  end
end