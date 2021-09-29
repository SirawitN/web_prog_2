class Post < ApplicationRecord
  belongs_to :user

  def valid_user_id(checkID)
    puts "checkID = #{checkID},......... #{self.user_id}"
    #puts "#{checkID.class}, #{user_id.class}"
    if checkID == self.user_id
      return true
    else 
      errors.add(:user_id, "is not matched!! You have no permission to perform this action.")
      return false
    end
  end
end
