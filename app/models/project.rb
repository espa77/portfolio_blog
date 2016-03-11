class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  mount_uploader :attachment, AvatarUploader
end
