class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def can_add_stock?(ticker)
    return user_stock_limit? && !stock_already_added(ticker)
  end

  def user_stock_limit?
    return user_stocks.count < 10
  end

  def stock_already_added(ticker)
    stock = Stock.find_by_ticker(ticker)
    return false unless stock
    return user_stocks.where(stock_id: stock.id).exists?


  end

  def full_name
    return "#{first_name} #{last_name}".strip if(first_name || last_name)
    "Anonymous"
  end

end
