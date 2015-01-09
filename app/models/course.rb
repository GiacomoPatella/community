class Course < ActiveRecord::Base
	belongs_to :user
	has_many :course_dates
	has_many :users	
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	


 	def check_last_bookings
 		tomorrow_date = DateTime.now + 1
 		tomorrow = tomorrow_date.strftime("%m/%d/%Y") 		
 	end

end

