class MessagesController < ApplicationController
  before_action :require_user

  def get_mod_message(message)
    render(partial: 'message', locals: {message: message})
  end

  def create
    message = current_user.messages.build(message_hash)
    if message.save
      ActionCable.server.broadcast('chatroom_channel', {mod_message: get_mod_message(message)})
    end
  end

  private

  def message_hash
    params.require(:message).permit(:body)
  end
end