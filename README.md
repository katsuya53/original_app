## users テーブル

| Column             | Type    | Options                    |
| ------------------ | ------- | -------------------------- |
| nickname           | string  | null: false                |
| email              | string  | null: false, unique: true  |
| encrypted_password | string  | null: false                |
| prefecture_id      | integer | null: false                | 

### Association
- has_many :posts
- has_many :likes
- has_many :follows, foreign_key: "follower_id", dependent: :destroy
- has_many :following_users, through: :follows, source: :followee
- has_many :reverse_follows, foreign_key: "followee_id", class_name: "Follow", dependent: :destroy
- has_many :followers, through: :reverse_follows, source: :follower
- has_many :comments
- has_many :blogs, dependent: :destroy
- has_many :records, dependent: :destroy
- has_many :categories, through: :records


## posts テーブル

| Column     | Type       | Options                        |
| -----------| ---------- | ------------------------------ |
| post_title | string     | null: false                    |
| post_text  | text       | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association

- has_many :likes
- has_many :comments
- has_many :post_tags
- has_many :tags, through: :post_tags


## likes テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| post   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post


## follows テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| follower | references | null: false, foreign_key: true |
| followee | references | null: false, foreign_key: true |

### Association

- belongs_to :follower, class_name: "User"
- belongs_to :followee, class_name: "User"


## comments テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| comment_text | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| post         | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :user


## tags テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| tag_name | string     | null: false, unique: true      |
| post     | references | null: false, foreign_key: true |

### Association

- has_many :post_tags
- has_many :posts, through: :post_tags


## post_tags テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| post_id | references | null: false, foreign_key: true |
| tag_id  | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :tag


## blogs テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| blog_title | string     | null: false                    |
| blog_text  | text       | null: false                    |
| datetime   | date       | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association

- belongs_to :user


## records テーブル

| Column      | Type       | Options                        |
| ----------  | ---------- | ------------------------------ |
| record_text | text       | null: false                    |
| user        | references | null: false, foreign_key: true |
| category    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category


## categories テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| category_name | string     | null: false, unique: true      |
| post          | references | null: false, foreign_key: true |

### Association

- has_many :records, through: :users