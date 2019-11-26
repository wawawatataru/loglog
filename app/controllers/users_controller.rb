# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to welcome_path, notice: "ユーザーを作成しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(id: @user.id), notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "削除しました"
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end