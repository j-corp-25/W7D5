class User < ApplicationRecord
  # FIGVAPER

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true

  attr_reader :password

  before_validation :ensure_session_token

  def self.find_by_credentials(username,password)
    user = User.find_by(username: username)

    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def is_password?(password)
    pwd = BCrypt::Password.new(self.password_digest)
    pwd.is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(64)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

end
