class Message < ApplicationRecord
  belongs_to :user
  validates :text, presence: { message: 'or image must be informed!'}, if: -> {image.blank?}

  attr_accessor :image

  before_save :save_image
  after_destroy :destroy_image

  def save_image
    return if self.image.blank?

    # TODO: save image on file system
    file_name = SecureRandom.uuid + File.extname(self.image.original_filename)
    file_url  = File.join('/uploads', file_name)
    file_path = File.join(Rails.root, 'public', file_url)

    File.open(file_path, 'wb') do |file|
      file.write(self.image.read)
    end  
    
    self.image_url = file_url  

  end

  def destroy_image
    return if self.image_url.blank?
    
    file_path = File.join(Rails.root, 'public', self.image_url)
    
    File.delete(file_path) if File.exist?(file_path)
  end

  def retweet(user)
    text = "RT from @#{self.user.name}: #{self.text}"

    Message.create(user: user, text: text, image_url: self.image_url)
  end  

end
