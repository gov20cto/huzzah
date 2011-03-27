class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # added name as a required field
  field :name
  validates_presence_of :name

  # names and emails must be unique, regardless of case
  validates_uniqueness_of :name, :email, :case_sensitive => false

  # protect from hackers using mass-assignment technique
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
