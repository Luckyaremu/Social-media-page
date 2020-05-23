module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def request_friendship(user1, user2)
    if Friendship.where(user_id: user1, friend_id: user2, confirmed: true).exists? ||
       Friendship.where(user_id: user2, friend_id: user1, confirmed: true).exists?
      1
    elsif Friendship.where(user_id: user2, friend_id: user1, confirmed: false).exists?
      2
    elsif Friendship.where(user_id: user1, friend_id: user2, confirmed: false).exists?
      3
    else
      4
    end
  end
end
