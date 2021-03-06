class Payment < ActiveRecord::Base
	belongs_to :course_date
	belongs_to :user		
	after_create :send_new_payment_email
	attr_accessor :stripe_card_token

	def save_with_payment
	  if valid?
	    customer = Stripe::Customer.create(card: stripe_card_token)
	    self.stripe_customer_token = customer.id
	    save!	    
	  end
		rescue Stripe::InvalidRequestError => e
		  logger.error "Stripe error while creating customer: #{e.message}"
		  errors.add :base, "There was a problem with your credit card."
		  false
	end

	def send_new_payment_email
		PaymentMailer.new_payment(self, user).deliver! if user
	end
end
