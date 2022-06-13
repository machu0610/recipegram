class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  #:authenticate_user!はdeviseを導入するとルカえるヘルパー
  #:authenticate_user!はログインしていない人は下記の全てのアクションにアクセスできなくなる。
  #expect: [:index]を書くとindexアクションだけはアクセスできるようになる。

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    #user_idはログインしている人
    #current_user.idは投稿するのはログインしている人
    #user_idのカラムにcurrent_user.id誰が投稿しているのかが保持される
    if @recipe.save
      #もしもセーブされたらしたの画面へいく
      redirect_to recipe_path(@recipe), notice: '投稿に成功しました。'
    else#バリデーションにかかってしまったらしたの画面にいく
      render :new
      #renderはアクションを返さずにそのビューを返すというもの
    end
    #バリデーションをかけるところはcreateアクション
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      #recipeに紐付いているuserとログインユーザーが一致しなければ
      redirect_to recipes_path, alert: '不正なアクセスです。'
      #何も言わないままの遷移はアレなのでメッセージを表示させる
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe),notice: '更新に成功しました。'
    else
      render :edit
    end
    #バリデーションをかけるところはupdateアクション
  end

  def destroy
    recipe = Recipe.find(params[:id])
    #削除したいレシピをRecipeモデルからひとつ持ってきてrecipeに格納する
    recipe.destroy
    #取り出してきたレシピを削除する
    redirect_to recipes_path
    #削除したら一覧に戻る
  end
  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end
end
