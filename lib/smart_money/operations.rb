module Operations

  def convert_to(new_currency)
    new_amount = Money.convert(@amount, @currency.upcase, new_currency.upcase).round(2)
    Money.new(new_amount, new_currency)
  end

  def inspect
    "#{@amount} #{@currency}"
  end

end
