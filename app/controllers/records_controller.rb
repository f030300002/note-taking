class RecordsController < ApplicationController

  def index
    @user_records = Record.where(user_id: params[:user_id]).order('record_date DESC').page params[:page]
    # @user_records.order('created_at DESC').page(params[:page]).per(per_page)
    @user = @user_records[0].user if @user_records.present?
  end

  def new
    @user_record = Record.new
    @user_record.user_id = params[:user_id]
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @user_record = @user.records.build user_id: params[:user_id], record_type: params[:record][:record_type], title: params[:record][:title], amount: params[:record][:amount], description: params[:record][:description], record_date: params[:record][:record_date]
    if @user_record.save
      flash.now[:success] = 'create user record succeed!'
      @user.update_amount('create', @user_record.amount, @user_record.record_type, @user.id)
      redirect_to user_record_url(@user, @user_record)
    else
      flash.now[:warning] = 'create user record failed!'
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @user_record = @user.records.find(params[:id])
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @user_record = @user.records.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @user_record = @user.records.find(params[:id])
    pre_amount = @user_record.amount
    if @user_record.update(record_params)
      flash.now[:success] = 'update user record succeed!'
      cur_amount = @user_record.amount
      @user.update_amount('update', cur_amount-pre_amount, @user_record.record_type, @user.id)
      redirect_to user_record_path(@user, @user_record)
    else
      flash.now[:warning] = 'update user record failed!'
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @user.update_amount('delete', @user.records.find(params[:id]).amount, @user.records.find(params[:id]).record_type, @user.id)
    @user.records.find(params[:id]).destroy
    flash.now[:success] = 'delete user succeed!'
    redirect_to user_records_path(@user)
  end

  private

  def record_params
    params.require(:record).permit(:record_type, :title, :description, :amount, :record_date)
  end

end
