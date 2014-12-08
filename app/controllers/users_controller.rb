class UsersController < ApplicationController

def show
  @user = User.find(params[:id])
end

def edit
	@user = User.find(params[:id])
end

def update	
	@user = User.find(params[:id])	
	@user.update_attributes(params[:user].permit(:first_name, :last_name, :contact_number))
	redirect_to current_user	
end

def index

end

def course_providers_index	
	@course_providers = []	
	User.all.each do |user|
		if user.type == "CourseProvider"
			@course_providers << user		
		end
	end 
	@course_providers
end

end
