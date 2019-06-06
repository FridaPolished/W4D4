# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  email           :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
validates :username, :email, :session_token, presence: true, uniqueness: true
validates :password_digest, presence: true
validates :password, length: {minimum: 6, allow_nil: true} 


    after_initialize :ensure_session_token

    attr_reader :password

    def self.generate_session_token
        ensure_session_token
        reset_session_token!
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

    def password=(password)
        @password = password
        encripted_password = BCrypt::Password.create(password)
        self.password_digest = encripted_password
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)

        return nil unless user
        user.is_password?(password) ? user : nil
    end

    def is_password?
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

end
