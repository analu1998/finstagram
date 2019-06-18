def humanized_time_ago(minute_num)
  if minute_num >= 60
    "#{minute_num / 60} hours ago"
  else
    "#{minute_num} minutes ago"
  end
end

get '/' do
  @finstagram_posts = FinstagramPost.order(created_at: :desc)
  erb(:index)
end

get '/test' do
  @user = {
      "username": "Jonny123",
      "friends": [
        "tom",
        "anna",
        "will",
        "Alex"
        ]
    }
  erb(:test)
end

get '/signup' do
  @user= User.new
  erb(:signup)
end

post '/signup' do
  email      = params[:email]
  avatar_url = params[:avatar_url]
  username   = params[:username]
  password   = params[:password]

  @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })

  if @user.save
    "User #{username} saved!"
  else
    erb(:signup)
  end
end