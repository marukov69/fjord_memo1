require "sinatra"
require "sinatra/reloader"
require "securerandom"

get '/memo' do
  @id= SecureRandom.alphanumeric(8)
  rbfiles = File.join("*.txt")
  @files = Dir.glob(rbfiles, base: "title") 
  erb :index
end

get '/memo/:id/new' do
  @id = params[:id]
  erb :new
end

post '/memo/:id' do
  @id = params[:id]
  title = params[:memo_title]
  main = params[:memo_main]
  File.open("title/#{@id}.txt", "w") do |f|
    f.puts("#{title}")
  end
  File.open("main/#{@id}.txt", "w") do |f|
    f.puts("#{main}")
  end
  erb :call
end

get '/memo/:id' do
  @id = params[:id]
  if params[:title_edited]
    @title_edited = params[:title_edited]
    File.open("title/#{@id}.txt", "w") do |f|
      f.puts("#{@title_edited}")
    end
  end
  if params[:main_edited]
    @main_edited = params[:main_edited]
    File.open("main/#{@id}.txt", "w") do |f|
      f.puts("#{@main_edited}")
    end
  end
  erb :call
end

get '/memo/:id/edit' do
  @id = params[:id]
  @title = File.read("title/#{@id}.txt")
  @main = File.read("main/#{@id}.txt")
  erb :edit
end

delete '/memo/:id' do
  @id = params[:id]
  FileUtils.rm("title/#{@id}.txt")
  FileUtils.rm("main/#{@id}.txt")
  erb :delete
end
