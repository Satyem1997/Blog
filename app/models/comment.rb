class Comment < ApplicationRecord

	belongs_to :post

	belongs_to :user

	has_attached_file :image, styles:{large: "150x150", medium: "100x100", thumb: "50x50"}

	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

	scope :sorted, lambda { order("sections.position ASC") }
	
end
