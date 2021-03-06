class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :user
  validates_presence_of :plan_id    
  attr_accessor :stripe_card_token
  attr_accessor :email
  
  def save_with_payment
    if valid?
      customer = Stripe::Customer.create(email: email, card: stripe_card_token, plan: plan_id)
      self.stripe_customer_token = customer.id
      save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end
end