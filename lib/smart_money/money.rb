require "smart_money/operations"

class Money
  
  include Operations

  attr_accessor :amount, :currency

  def initialize(amount = nil , currency = nil)
    @amount = amount
    @currency = currency.upcase if !currency.nil?
  end

  class << self

    def conversion_rates(currency, rates)
      if !currency.nil? && !rates.nil?
        @conversion_rates_table = {} if @conversion_rates_table.nil?
        rates.each do |curr,value|
          @conversion_rates_table[ [currency.upcase, curr.upcase] ] = value
          @conversion_rates_table[ [curr.upcase, currency.upcase] ] = (1/value.to_f).round(2)
          @conversion_rates_table[ [curr.upcase, curr.upcase] ] = 1
          @conversion_rates_table[ [currency.upcase, currency.upcase] ] = 1
        end
      else
        raise ArgumentError, "currency or rates attributes can't be be blank"
      end
    end

    def convert(amount, currency, to_currency)
      if !@conversion_rates_table[[currency.upcase, to_currency.upcase]].nil?
        @conversion_rates_table[ [currency.upcase, to_currency.upcase]] * amount
      else
        raise ArgumentError, "conversion rate is not defined for '#{currency}'"
      end
    end

  end

end