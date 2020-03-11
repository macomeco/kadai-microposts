class Micropost < ApplicationRecord
    belongs_to :user
    validates :content, presence: true, length: {maximum: 255}
    
    #fav
    #postをfavしたユーザ
    has_many :favorites
    has_many :favorite_users, through: :favorites , source: :user
    
    #has_many :reverses_of_favorite, class_name: 'Favorite', foreign_key: 'micropost_id' #favされたポスト
    #has_many :favorite_users, through: reverses_of_favorite, source: :user　#favしたユーザら
    
    def fav(user)
        favorites.find_or_create_by(user_id: user.id)
    end
    
    def unfav(user)
        favorite = favorites.find_by(user_id: user.id)
        favorite.destroy if favorite
    end
    
    def fav?(user)
        favorite_users.include?(user)
    end
end
