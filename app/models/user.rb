class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #attr_accessor :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  has_many :orders
  has_many :products, through: :orders



end
