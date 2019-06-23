class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
 
  def self.find_for_mock(auth)
     parameters = { 
       name:     auth.info.name,
       email:    auth.info.email,
       provider: auth.provider,
       uid:      auth.uid,
       token:    auth.credentials.token,
       password: Devise.friendly_token[0, 20],
       raw: auth.extra.to_json
     }   
     user = User.find_by(uid: auth.uid)
     return update_mock!(user, parameters) if user
 
     User.create(parameters)
  end 
 
  def self.update_mock!(user, parameters)
    user.update(parameters)
    user
  end

  include Redis::Objects

  attr_accessor :name

  list :list_weight
  hash_key :hash_value

  # 体重を保存する
  def store_weight(weight)
    list_weight << weight
  end

  def redis_hash
    name = 'hoge'
    save

    hash_value["3"] = {
      name: 'hoge',
      type: 'novel',
      author: 'Tom'
    }
    hash_value["2"] = {
      name: 'fuga',
      type: 'novel',
      author: 'John'
    }
    hash_value["1"] = {
      name: 'How to Ruby',
      type: 'study',
      author: 'M'
    }
    hash_value["5"] = {
      name: 'japanese history',
      type: 'history',
      author: 'japan'
    }
    hash_value["4"] = {
      name: 'death note',
      type: 'commic',
      author: 'obata'
    }

    sorted = hash_value.all.sort.to_h
    hash_value.clear
    hash_value.bulk_set(sorted)
  end


end