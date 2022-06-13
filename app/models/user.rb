class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image # ここを追加（_idは含めない）

  has_many :recipes, dependent: :destroy
  #一人のユーザーはたくさんのレシピを持っているという意味
  #dependent: :destroyはユーザーが削除されたら紐付いているレシピも一緒に削除される

  validates :username, presence: true
end
