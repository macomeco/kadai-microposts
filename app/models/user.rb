class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
#=begin
    has_many :microposts
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    def follow(other_user)  #自分ではないこと、すでにフォローしているかどうかを確認し、フォローをする
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)    #フォローしているか確認後、フォローをはずす
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)  #ふぉろーしているかどうかの確認
        self.followings.include?(other_user)
    end
    
    def feed_microposts #タイムライン用のポスト取得
        Micropost.where(user_id: self.following_ids + [self.id] ) #has many...→ふぉろーしてる人のid,自分のidのポスト取得
    end
#=end

end
