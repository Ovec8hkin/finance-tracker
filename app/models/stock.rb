class Stock < ActiveRecord::Base

  def self.find_by_ticker(ticker)

    where(ticker: ticker).first

  end

  def self.new_from_lookup(ticker)

    looked_up_stock = StockQuote::Stock.quote(ticker)
    return nil unless looked_up_stock.name

    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.price = new_stock.get_price

    return new_stock

  end

  def get_price

    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price}" if closing_price

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price}" if opening_price

    return "Unavailable"


  end

end