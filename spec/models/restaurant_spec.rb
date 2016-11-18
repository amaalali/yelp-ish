require 'rails_helper'

describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = helper_create_restaurant(name: 'Fr', description: 'abc')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    helper_create_restaurant
    restaurant = helper_create_restaurant(name: 'Frank Doubles',
                                          description: 'Another Frank')
    expect(restaurant).to have(1).error_on(:name)
  end
end
