class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  before_create :confirm_participant
  after_create_commit { broadcast_append_to room }

  def confirm_participant
    if room.is_private
      is_participant = Participant.where(user_id: user.id, room_id: room.id).first
      throw :abort unless is_participant
    end
  end
end
