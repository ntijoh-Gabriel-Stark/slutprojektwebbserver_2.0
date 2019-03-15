require 'byebug'
require 'bcrypt'
require 'rack-flash'
require_relative 'models/users'
require_relative 'models/database_object'

class App < Sinatra::Base
	enable :sessions
	use Rack::Flash

	before do
		if (request.path != "/" && request.path != '/login') && session[:user_id] == nil
			redirect '/'
		else
			if session[:user_id]
				@current_user = Users.get({id: session[:user_id]})
			end
		end
	end

	get '/' do
		slim :index
	end

	post '/login' do
		errors = {}
		if params[:name].empty?
			errors[:name] = "Man måste skriva in sitt namn."
		end
		
		users = Users.all() { {join: "role_name"} }
		errors[:error] = "Fel lösenord eller namn."
		for user in users
			if user.name == params['name']
				errors.delete(:error)
				break
			end
		end

		if errors.empty?
			Users.login(params, self) { {join: "role_name"} }
		end

		if !session[:user_id]
			errors[:error] = "Fel lösenord eller namn."
		end

		if errors.any?
			flash[:errors] = errors
		else
			flash[:success] = "Registration successful"
		end
		redirect back
	end

	post '/logout' do
		session.destroy
		redirect '/'
	end

	get '/add' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		@users = Users.all() { {join: "role_name"} }
		@groups = Groups.all()
		@subjects = Subject.all()
		slim :'add/index'
	end
	
	post '/teacher_subject' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		Teacher_subject.input({teacher_id: params['user'], subject_id: params['subject']})
		redirect '/'
	end

	post '/add_person' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		pwd = BCrypt::Password.create(params['pwd'])
		Users.input({email: params['email'], name: params['name'], hashed_password: pwd, role_id: params['login_type']})
		redirect '/'
	end

	post '/add_group' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		Groups.input({group_name: params['name']})
		redirect '/'
	end

	post '/add_person_to_group' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		User_group.input({user_id: params['user'], group_id: params['group']})
		redirect '/'
	end

	get '/browse' do
		@users = Users.all() { {join: "role_name"} }
		slim :'browse/index'
	end

	get '/groups' do
		@groups = Groups.all()
		@member_groups = Groups.merge({fetch: 'group_id', table: 'user_group', user_id: @current_user.id})
		slim :'groups/index'
	end

	get '/groups/:id' do
		@users = Users.merge({fetch: 'user_id' ,table: 'user_group', group_id: params['id']})
		slim :'groups/members'
	end

	get '/user/:id' do
		unless session[:type] == 'teacher' || @current_user.id == params['id'].to_i
			halt 403
			redirect back
		end
		@grades = Grading.filter({student_id: params['id']})
		@student = Users.get({id: params['id']}) { {join: "role_name"} }
		@subjects = Subject.all()
		@users = Users.all() { {join: "role_name"} }
		slim :'user/index'
	end

	post '/set_grade' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		Grading.input({teacher_id: params['teacher_id'], student_id: params['student_id'], subject_id: params['subject_id'], grade: params['grade'], comment: params['comment']})
		redirect back
	end

	post '/change_grade' do
		unless session[:type] == 'teacher'
			halt 403
			redirect back
		end
		Grading.update({grade: params['grade'], comment: params['comment'], id: params['id']})
		redirect back
	end
end