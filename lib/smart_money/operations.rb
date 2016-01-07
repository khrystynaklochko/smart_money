module SmartMoney
  module Operations
  
    include Comparable

    def convert_to(new_currency)
      new_amount = Money.convert(@amount, @currency.upcase, new_currency.upcase).round(2)
      Money.new(new_amount, new_currency)
    end

    def inspect
      "#{@amount} #{@currency}"
    end
  
    def +(other)
      raise TypeError unless other.is_a?(Money)
      Money.new @amount+other.convert_to(@currency).amount, @currency
    end

    def -(other)
      raise TypeError unless other.is_a?(Money)
      Money.new @amount-other.convert_to(@currency).amount, @currency
    end

    def *(value)
      Money.new @amount*value, @currency if value.is_a?(Numeric)
    end

    def /(value)
      Money.new @amount/value, @currency if value.is_a?(Numeric)
    end

    def ==(other)
      raise TypeError unless other.is_a?(Money)
      @amount.round(2)==other.convert_to(@currency).amount.round(2)
    end

    def <=>(other)
      raise TypeError unless other.is_a?(Money)
      if @currency != other.currency
        other = other.convert_to(@currency)
      end
      @amount.round(2) <=> other.amount.round(2)
    end
  end
end
