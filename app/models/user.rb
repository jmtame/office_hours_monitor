class User < ActiveRecord::Base
  attr_accessible :active, :email, :name
end
