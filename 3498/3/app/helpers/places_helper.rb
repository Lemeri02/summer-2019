module PlacesHelper
  def load_place_info
    session[:place_name] = params[:place_name].to_s
    @place = Place.find_by(name: params[:place_name].to_s)
    session[:place_id] = @place.id
  end

  def rate_place
    redirect '/login' unless login?
    @user = User.find(session[:user_id])
    add_comment
  end

  def add_comment
    @comment = Comment.new
    @comment = @user.comments.create(rating: params[:rate].to_i, text: params[:text])
    @comment.place_id = session[:place_id].to_s
    @comment.save
  end

  def login?
    session[:user_id]
  end
end
