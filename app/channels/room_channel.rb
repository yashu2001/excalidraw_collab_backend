class RoomChannel < ApplicationCable::Channel
  def subscribed
    if params[:room_id].present?
      # creates a private chat room with a unique name
      p "Requesting to subscribe to #{params[:room_id]}"
      stream_from("ChatRoom-#{params[:room_id]}")
    end
  end

  def speak(data)
    room_id=data["room_id"]
    payload=data["payload"]
    user=data["user"]
    raise "No room id" if room_id.blank?
    ActionCable.server.broadcast("ChatRoom-#{room_id}",{:payload=>payload,:user=>user})
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
