class UsersController < ApplicationController  
  before_filter :check_perm, :only => [ :edit, :update, :destroy ]

  def check_perm
    @user = User.find(params[:id])
    if current_user == nil
      flash[:notice] = "Sorry, plz login first"
      redirect_to posts_path
    elsif @user.id != current_user.id 
      flash[:notice] = "Sorry, you are not allowed to edit other's profile"
      redirect_to posts_path
    end
  end
  def new  
    @user = User.new  
  end

  def edit
  end

  def update
    @user.attributes = params[:user]
    @user.save!                
    redirect_to @user, :notice => "Successfully updated profile."                                                         
  end  
    
  def create  
 # this method is called when you click the "created user" button, then I see
 # in Firebug a "post users" request, so according to 
 # http://guides.rubyonrails.org/routing.html
 # the users#create will be called
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to root_url, :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end  
end  
  def index
      @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  def show
    if params[:name]
      @user = User.where(:name => params[:name]).first
    else
      @user = User.find(params[:id])
    end
    if @user == nil
      redirect_to root_url, :notice => "no such user!"  
    else
      respond_to do |format|
        format.html # show.html.erb
    end
  end
end
