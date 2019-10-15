#管理者のみ利用可能　ユーザーの登録・削除・編集機能
class Admin::UsersController < ApplicationController
  before_action :require_admin
  
  #ユーザー一覧表示
  def index
    #全ユーザーを取得しインスタンス変数へ格納
    @users = User.all
  end

  #個別ユーザー情報参照
  def show
    #IDに紐づくユーザーを取得しインスタンス変数へ格納
    @user = User.find(params[:id])
  end

  #新規ユーザー登録準備
  def new
    #新規インスタンスを生成しインスタンス変数へ格納
    @user = User.new
  end

  #ユーザー編集
  def edit
    #編集対象のユーザーを取得しインスタンス変数へ格納
    @user = User.find(params[:id])
  end

  #新規ユーザー登録
  def create
    #POSTされたパラメータでユーザーインスタンスを作成する
    @user = User.new(user_params)

    #ユーザーの登録
    if @user.save
      #エラーが無ければ/admin/users/indexへリダイレクト　その際にフラッシュメッセージnoticeにメッセージを渡す
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      #エラーの場合新規登録ビューへ返す
      render :new
    end
  end

  #ユーザー情報更新
  def update
    @user = User.find(params[:id])

    #POSTされたパラメータでユーザーを更新する
    if @user.update(user_params)
      #エラーが無ければ/admin/users/showへリダイレクト　その際にフラッシュメッセージnoticeにメッセージを渡す
      redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      #エラーの場合新規登録ビューへ返す
      render:new
    end
  end

  #ユーザー削除処理
  def destroy
    @user = User.find(params[:id])
    #ユーザーの削除
    @user.destroy
    #エラーが無ければ/admin/users/showへリダイレクト　その際にフラッシュメッセージnoticeにメッセージを渡す
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  #private以下がこのクラスで使えるプライベートメソッドになる
  private

  def user_params
    #パラメータからユーザーモデルのname, email, admin, password, password_confirmationを取得する
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
