class BooksController < ApplicationController
    before_action :authenticate_user!
def index
  flash[:error].clear if flash[:error]
  @user = current_user

  if params[:user_id]
    @user = User.find(params[:user_id])
    @books = @user.books
  else
    @books = Book.all
  end
end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
def destroy
  @book = Book.find(params[:id])
  if @book.destroy
    flash[:notice] = "本を削除しました。"
    redirect_to user_books_path
  else
    flash[:alert] = "本の削除に失敗しました。"
    render :show
  end
end

def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id

  if @book.save
    redirect_to book_path(@book), notice: '本が投稿されました。'
  else
    flash.now[:error] = @book.errors.full_messages.to_sentence
    @books = Book.all
    render 'index'
  end
end

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to book_path(@book), notice: '本の情報を更新しました。'
  else
    flash.now[:error] = @book.errors.full_messages.to_sentence
    render :edit
  end
end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end