class Recipe < ApplicationRecord
  belongs_to :user
  #レシピがユーザー一人にからなず属する
  attachment :image

  with_options presence: true do
    #with_optionsは複数指定したい場合に使用できる。
    #presence: trueは空の投稿ができないように制約をかけている。
    validates :title
    validates :body
    validates :image
    #空にしたくないカラムをvalidateの後ろに記述する。
  end
end
