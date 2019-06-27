
class User < ActiveRecord::Base

  has_many :finstagram_posts
  has_many :comments
  has_many :likes

  validates_presence_of :email,
                        :avatar_url,
                        :username,
                        :password

  validates_uniqueness_of :email,
                          :username

  def like_for_finstagram_post_id(finstagram_post_id)
    likes.find_by finstagram_post_id: finstagram_post_id
  end

end