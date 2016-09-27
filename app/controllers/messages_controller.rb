class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    if params.include?(:contact_id)
      @contact = Contact.find(params[:contact_id])
    end
    @message = Message.new
  end

  def create
    if params.include?(:id)
      @contact = Contact.find(params[:id])
    end
    binding.pry
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "Your message was sent!"
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private

    def message_params
      params.require(:message).permit(:from, :body, :contacts_attributes, to:[])
    end
  end
