class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation :init_blog_name
  validates :blog_name, presence: true, uniqueness: true, :format =>{ with: /\A[a-zA-Z]*\z/,}

  protected

  def init_blog_name
    self.blog_name = ('a'..'z').to_a.shuffle[0,8].join if self.blog_name.blank?
  end
end
