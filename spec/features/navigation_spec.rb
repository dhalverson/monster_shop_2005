
require 'rails_helper'

describe 'As a visitor' do
  it 'I see a link to browse all items for sale' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('All Items')
      click_link 'All Items'
    end

    expect(current_path).to eq('/items')
  end

  it 'I see a link to see all merchants' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('All Merchants')
      click_link 'All Merchants'
    end

    expect(current_path).to eq('/merchants')
  end

  it 'I see a cart indicator link' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Cart: 0')
      click_link 'Cart: 0'
    end

    expect(current_path).to eq('/cart')
  end

  it 'I see a register link' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Register')
      click_link 'Register'
    end

    expect(current_path).to eq('/register')
  end

  it 'I see a link to home' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Home')
      click_link 'Home'
    end

    expect(current_path).to eq('/')
  end

  it 'I see a link to login' do
    visit '/'

    within 'nav' do
      expect(page).to have_link('Login')
      click_link 'Login'
    end

    expect(current_path).to eq('/login')
  end


  describe "as a merchant employee" do
    it "shows the same links as a regular user and a linnk to the merchant dashboard" do
      merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)


      visit '/items'

      within 'nav' do
        expect(page).to have_link("Merchant Dashboard")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
      end

      within 'nav' do
        click_link 'Merchant Dashboard'
        expect(current_path).to eq('/merchant')
      end
    end
  end


  describe "as a merchant employee" do
    it "shows the same links as a regular user and a linnk to the merchant dashboard" do
      merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)


      visit '/items'

      within 'nav' do
        expect(page).to have_link("Merchant Dashboard")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
      end

      within 'nav' do
        click_link 'Merchant Dashboard'
        expect(current_path).to eq('/merchant')
      end
    end
  end
end
