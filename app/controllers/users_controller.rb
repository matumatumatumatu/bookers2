class UsersController < ApplicationController
    before_action :authenticate_user!
  def index
    @users = User.includes(:books).all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end
  
def edit
  @user = User.find(params[:id])
  redirect_to post_images_path unless @user.id == current_user.id
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user), notice: 'プロフィールを更新しました。'
  else
    flash.now[:error] = 'プロフィールの更新に失敗しました。'
    render :edit
  end
end

def user_params
  params.require(:user).permit(:name, :introduction) # その他の許可されたパラメータ
end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end
end