class User < ApplicationRecord
  
  after_initialize :ensure_session_token 
  #anytime a new user instance is initialized, 
  #ie when a new user is created or signed in 
  #the user is fetched from the database and 
  #a new user instance is created (through the controller),
  #a session token is checked for and then assigned 
  
  validates :email, :password_digest, :session_token, presence: true 
  validates :password, length: {minimum: 6, allow_nil: true }
  
  attr_reader :password 
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil if user.nil? 
    return user if user.is_password?(password)
  end 
  
  def self.generate_session_token #just make a string, not assigned yet
    SecureRandom.urlsafe_base64(16)
  end 
  
  def reset_session_token!
    self.session_token = User.generate_session_token 
    self.save!
    self.session_token  
  end 
  
  def ensure_session_token 
    self.session_token ||= User.generate_session_token 
  end 
  
  def password=(password)
    @password = password 
    
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end 
end
