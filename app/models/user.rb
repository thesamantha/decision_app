class User < ActiveRecord::Base

  before_save { self.email = self.email.downcase }   # before object is saved to database, convert it to all lowercase letters

  validates(:name, presence: true, length: { maximum: 50} )

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 

  validates(:email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false } )

  validates(:password, presence: true, length: {minimum: 6} )

  has_secure_password   # method allows us to save a securely hashed password_digest attribute to the database, supplies us with the virtual attrbutes password and password_confirmation with presence validations upon object creation and another validation requiring that they match, and an authenticate method that returns the user when the password is correct, false otherwise
                        # requires the corresponding model (User) to have an attribute called password_digest (accomplished through a migration)

end

