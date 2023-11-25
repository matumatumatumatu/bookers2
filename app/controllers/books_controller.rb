class BooksController < ApplicationController
    before_action :authenticate_user!
def index
  flash[:error].clear if flash[:error]
  @user = current_user
  @book = Book.new
  @books = Book.all
end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
    # 投稿の所有者でなければリダイレクトする
    redirect_to books_path unless @book.user == current_user
  end
  
  def destroy
  @book = Book.find(params[:id])
  if @book.destroy
    flash[:notice] = "本を削除しました。"
    redirect_to books_path # すべてのユーザーの投稿一覧へリダイレクト
  else
    flash[:alert] = "本の削除に失敗しました。"
    render :show
  end
  end

def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id

  if @book.save
    redirect_to book_path(@book), notice: 'The book was successfully posted.'
  else
    flash.now[:error] = @book.errors.full_messages.to_sentence
    @books = Book.all
    @user = current_user
    render 'index'
  end
end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'The book was successfully updated.'
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