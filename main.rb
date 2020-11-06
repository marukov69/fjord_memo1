require "sinatra"
require "sinatra/reloader"

get '/memo' do
  erb :index
end

post '/memo/new' do
  @user = params[:user_name]
  f = File.open("#{@user}.txt", "w") 
  f.close
  redirect "/memo/#{@user}/new"
end

post '/memo/existing' do
  @user = params[:user_name]
  redirect "/memo/#{@user}"
end

get '/memo/:user_name/new' do
  @user = params[:user_name]
  erb :input
end

post '/memo/:user_name' do
  @user = params[:user_name]
  @input = params[:memo_main]
  File.open("#{@user}.txt", "w") do |f|
    f.puts("#{@input}")
  end
  erb :call
end

get '/memo/:user_name' do
  @user = params[:user_name]
  if params[:memo_edited]
    @edited = params[:memo_edited]
    File.open("#{@user}.txt", "w") do |f|
      f.puts("#{@edited}")
    end
  end
  erb :call
end

get '/memo/:user_name/edit' do
  @user = params[:user_name]
  @input = File.read("#{@user}.txt")
  erb :edit
end
