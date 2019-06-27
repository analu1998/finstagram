helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

get '/' do
  @finstagram_posts = FinstagramPost.order 'created_at DESC'
  erb :index
end

get '/signup' do
  @user = User.new
  erb :signup
end

post '/signup' do
  @user = User.new params.slice('email', 'avatar_url', 'username', 'password')
  if @user.save
    redirect to("/login")
  else
    erb :signup
  end
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by username: params[:username]
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect to("/")
  else
    @error_messages = ["Could not authenticate user."]
    erb :login
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect to("/")
end

get '/posts/new' do
  @post = FinstagramPost.new
  erb :"posts/new"
end

get '/posts/:id' do
  @post = FinstagramPost.find params[:id]
  erb :"posts/show"
end

post '/posts' do
  @post = FinstagramPost.new params.slice('photo_url', 'user_id')
  if @post.save
    redirect to("/")
  else
    erb :"posts/new"
  end
end

post '/comments' do
  Comment.create params.slice('text', 'finstagram_post_id', 'user_id')
  redirect back
end

post '/likes' do
  Like.create params.slice('finstagram_post_id', 'finstagram_post_id')
  redirect back
end

delete '/likes/:id' do
  Like.find(params[:id]).destroy
  redirect back
end