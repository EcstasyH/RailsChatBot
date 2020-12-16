require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "no repeated users" do
    user1 = User.create(username:"test@mails.com")
    user2 = User.create(username:"test@mails.com")
    user1.save
    assert_not user2.save
  end
end
