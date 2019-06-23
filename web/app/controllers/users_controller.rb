class UsersController < ApplicationController
  def redis
    user = User.new
    user.name = "John"
    user.password = "password"
    user_count = User.count
    user.email = "aaa#{user_count}@co.jp"
    user.save
    # user = User.find(5)
    user.store_weight(65)
    user.store_weight(64.5)
    user.store_weight(66)
    user.store_weight(66)
    @data = user.list_weight
  end
end
