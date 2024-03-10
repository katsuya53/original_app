=begin
新しいアプリを作成
title、text、写真を投稿できるpostsモデル
nickname、email。passwordをユーザー登録してログインユーザーを管理するusersモデル
ユーザーが投稿にいいねをできるlikesモデル
ユーザーがフォローすることができ、フォロした人、フォロワーを管理するfollowsモデル
投稿にコメントとしてtextを投稿できるcommentモデル
カレンダーにtitle、text、datetimeを登録できるblogsモデル
また、カレンダーに登録した日時datetimeにメールを配信してくれるようになっています

ユーザー登録したユーザがログインすれば、全ての機能を利用できますが、
ユーザー登録しなくても、公開範囲の制限によって閲覧できるものは閲覧できます

公開範囲という設定にして、
誰でも(public)：ログインしていない人も閲覧できる
登録者(private)：ログインしているユーザーだけ閲覧
非公開(personal)：投稿したユーザーだけ閲覧

=end



モデルへの公開範囲の追加:
visibility 列を enum として使用して、公開範囲を管理します。

ruby
Copy code
# app/models/post.rb
class Post < ApplicationRecord
  enum visibility: { public: 0, private: 1, personal: 2 }

  # 他のモデルの関連やバリデーションなど...
end
ここでは、public、private、personalがそれぞれ「誰でも見れる」、「登録者だけが見れる」、「非公開」を表しています。

投稿フォームの変更:
フォームに公開範囲の選択肢を追加します。

ruby
Copy code
<%= form.label :visibility, "公開範囲" %>
<%= form.select :visibility, Post.visibilities.keys %>
アクセス制御の追加:
投稿を表示する際に、公開範囲に基づいて条件分岐します。

ruby
Copy code
# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @post = Post.find(params[:id])

    case @post.visibility
    when 'public'
      # 誰でも見れる
      render :show
    when 'private'
      # ログインしているユーザーだけが見れる
      if user_signed_in?
        render :show
      else
        redirect_to root_path, alert: "この投稿は登録者だけが閲覧できます。"
      end
    when 'personal'
      # 投稿を作成したユーザーだけが閲覧可能
      if user_signed_in? && @post.user == current_user
        render :show
      else
        redirect_to root_path, alert: "この投稿は非公開です。"
      end
    end
  end

  # 他のアクションも同様に処理 ...
end
これで、公開範囲に基づいて投稿の閲覧制御が実装されます。必要に応じてメッセージやリダイレクト先を変更してください。






