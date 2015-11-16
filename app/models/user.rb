class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :init_username
  validates :username, presence: true, uniqueness: true, :format =>{ with: /\A[a-zA-Z]*\z/,}

  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  protected

  def init_username
    self.username = ('a'..'z').to_a.shuffle[0,8].join if self.username.blank?
  end
end
