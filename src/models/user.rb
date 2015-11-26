class User < ActiveRecord::Base

  validates :username,   presence: true , length: { minimum: 6  }
  validates :password,   presence: true

end
