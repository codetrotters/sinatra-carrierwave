require './uploaders/images_uploader'

class Image < ActiveRecord::Base
  mount_uploader :file, ImagesUploader
end
