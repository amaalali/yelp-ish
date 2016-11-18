require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end

describe Restaurant do
  it 'is not valid unless it has a unique name' do
    user = User.create(email: "tommy@tommy.com", password: "tommeetippee")
    Restaurant.create(name: "Moe's Tavern", description: "Work!", user_id: user.id)
    moes2 = Restaurant.new(name: "Moe's Tavern", description: "Work!", user_id: user.id)
    expect(moes2).to have(1).error_on(:name)
  end
end
