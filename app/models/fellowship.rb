class Fellowship < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followed_user, class_name: 'User'

  #validates :followed_user, uniqueness: { scope: %i[follower_user], message: 'já está sendo seguido'}

  validate :self_following
  validate :unique_following, on: :create

  scope :active, -> { where(deleted_at: nil)}

  def destroy
    self.deleted_at = Time.now
    self.save

    self
  end

  private

  def self_following
    return if follower_user_id != followed_user_id

    errors.add(:base, "You cannot follow yourself!")
   
  end

  def unique_following
    return unless Fellowship.active.where(follower_user: follower_user, followed_user: followed_user, deleted_at: nil).exists?

    errors.add(:base, 'You are already following this user!')
   
  end

end
