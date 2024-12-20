class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @quiz_collection = QuizCollection.new 
    @quiz_collections = @user.quiz_collections
    @books = @user.books
  end

  def edit
    @now_user = current_user
    @user = User.find(params[:id])
    if @now_user != @user
      redirect_to user_path(id: @now_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(id: @user.id)
    else
      @user = @user
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
