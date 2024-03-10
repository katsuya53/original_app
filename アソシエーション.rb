# app/models/user.rb
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :follows, source: :followee
  has_many :inverse_follows, class_name: 'Follow', foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :inverse_follows, source: :follower
  has_many :blogs, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :categories, through: :records
end

# app/models/post.rb
class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
end

# app/models/like.rb
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
end

# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
end

# app/models/follow.rb
class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
end

# app/models/blog.rb
class Blog < ApplicationRecord
  belongs_to :user
end

# app/models/record.rb
class Record < ApplicationRecord
  belongs_to :user
  belongs_to :category
end

# app/models/category.rb
class Category < ApplicationRecord
  has_many :records
  has_many :users, through: :records
end

# app/models/tag.rb
class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags
end

# app/models/post_tag.rb
class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
end