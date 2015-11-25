class Micropost < ActiveRecord::Base
  belongs_to :user 	# GENERATED AUTOMATICALLY BY MIGRATION

  # LIKE

  has_many :likes, dependent: :destroy

  # LIKE

  default_scope -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true

  validates :content, presence: true, length: { maximum: 140 }

  validate 	:picture_size

  def likedby(user)
    likes.create(user_id: user.id)
  end

  def unlikedby(user)
    likes.find_by(user_id: user.id).destroy
  end

  private

  		def picture_size
  			if picture.size > 5.megabytes
  				errors.add(:picture, "Image should be less than 5 MB")
  			end
  		end

end
