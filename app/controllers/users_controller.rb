class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  #:authenticate_user!はdeviseを導入するとルカえるヘルパー
  #:authenticate_user!はログインしていない人は下記の全てのアクションにアクセスできなくなる。
  #expect: [:index]を書くとindexアクションだけはアクセスできるようになる。

  def index
    @users = User.all
    #ユーザーはくさんいるので複数形にする
  end

  def show
    @user = User.find(params[:id])
    #一人のユーザーの情報を取ってきて@userに渡す
    #(params[:id])はURLから取ってきている
    #UserモデルのDBに登録してあるIDを取ってきている
  end

  def edit
    @user = User.find(params[:id])
    if @user !=current_user
      redirect_to users_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @user = User.find(params[:id])
    #どのユーザーを更新するのか見つけてきて
    if @user.update(user_params)
      #@userを更新する。どのカラムを更新するのか
      #ここのuser_paramsはprivate以下の定義から取ってきている
      redirect_to user_path(@user), notice: '更新に成功しました。'
      #ユーザーの詳細画面に返る
    else
      render :edit
    end
  end

  private
  #ここはユーザーコントローラーの中でしか使えない
  def user_params
    params.require(:user).permit( :username, :email, :profile, :profile_image)
    #requireの後ろはモデル名
    #permitの後ろは更新するカラム
  end
end
