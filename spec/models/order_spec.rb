require 'rails_helper'

describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it {should belong_to(:user).optional}
    it {should have_many :item_orders}
    it {should have_many(:items).through(:item_orders)}
  end

  describe 'instance methods' do
    before :each do
      @meg = create(:merchant)
      @brian = create(:merchant, name: "Brian's Dog Shop")

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      user_1 = User.create!(name: 'Jeff Bezos', address: '123 Main Street', city: 'Denver', state: 'CO', zip: '80123', email: 'jbezos@amazon.com', password: 'Hunter2', role: 0)

      @order_1 = user_1.orders.create!(name: "Human Person", address: "Address", city: "City", state: "State", zip: "12345", status: "pending")
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
    end

    it 'grandtotal' do
      expect(@order_1.grandtotal).to eq(230)
    end

    it 'item_attributes_update' do
      @order_1.item_attributes_update(@order_1)
      expect(@order_1.item_orders.first.status).to eq("unfulfilled")
      expect(@order_1.item_orders.last.status).to eq("unfulfilled")
      expect(@order_1.items.first.inventory).to eq(12)
      expect(@order_1.items.last.inventory).to eq(32)
    end
  end
end
