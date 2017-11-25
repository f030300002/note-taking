class NotesController < ApplicationController
  def index
    @user_notes = Note.where(user_id: params[:user_id]).order('note_date DESC').page params[:page]
    # @user_records.order('created_at DESC').page(params[:page]).per(per_page)
    @user = @user_notes[0].user if @user_notes.present?
  end

  def new
    @user_note = Note.new
    @user_note.user_id = params[:user_id]
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @user_note = @user.notes.build note_params
    if @user_note.save
      flash.now[:success] = 'create user note succeed!'
      redirect_to user_note_url(@user, @user_note)
    else
      flash.now[:warning] = 'create user note failed!'
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @user_note = @user.notes.find(params[:id])
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @user_note = @user.notes.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @user_note = @user.notes.find(params[:id])
    if @user_note.update(note_params)
      flash.now[:success] = 'update user note succeed!'
      redirect_to user_note_path(@user, @user_note)
    else
      flash.now[:warning] = 'update user note failed!'
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.notes.find(params[:id]).destroy
    flash.now[:success] = 'delete user note succeed!'
    redirect_to user_notes_path(@user)
  end

  private

  def note_params
    params.require(:note).permit(:description, :note_date)
  end

end
