require 'spec_helper'
require 'smart_money'
describe Money do
  
  context "Money instance " do
   
    it "can create empty money instance" do
      euros = Money.new
      expect(euros.amount).to eql(nil)
      expect(euros.currency).to eql(nil)
    end

    it "can create 0 value" do
      euros = Money.new(0, 'Euros')
      expect(euros.amount).to eql(0)
      expect(euros.currency).to eql("EUROS")
    end

  end

  context "conversions" do
    
    it "can remember conversion_rates" do
      Money.conversion_rates('USD', {'EURO'=> 1.1})
      expect(Money.convert(1, 'USD', 'euro')).to eql(1.1)
    end
  
    it "can convert from one currency to another" do
      Money.conversion_rates('USD', {'EURO'=> 1.11})
      dollars = Money.new(100, 'USD')
      euro = dollars.convert_to('EURO')
      e = dollars.convert_to('EURO')
      expect(euro.currency).to eq('EURO')
      expect(euro.amount).to eq(111.round(2))
      expect(e.currency).to eq('EURO')
    end
  
    it "can return inspected object" do
      euros = Money.new(0, 'Euros')
      expect(euros.inspect).to eql("0 EUROS")
    end

    it "can converts to itself" do
      Money.conversion_rates('USD', {'EURO'=> 1.1})
      dollars = Money.new(100, 'USD')
      expect {dollars.convert_to('USD')}.to_not raise_error(ArgumentError) 
    end

    it "raise an error, when conversion rate is not set" do
      dollars = Money.new(100, 'USD')
      expect {dollars.convert_to('EUR')}.to raise_error(ArgumentError) 
    end

    it "raise an error, when conversion rate has empty attributes" do
      expect {Money.conversion_rates}.to raise_error(ArgumentError) 
    end

  end

   context " arithmetic operations" do
   
    it "can add money in same currency" do
      one_usd = Money.new(1, 'USD')
      one_usd_1 = Money.new(1,'USD')
      sum = one_usd + one_usd_1
      expect( sum.currency.to_s ).to eq( "USD" )
      expect( sum.amount).to eq(2.0)
    end

    it "can add money in different currencies" do
      Money.conversion_rates('USD', {'EURO'=> 0.9})
      one_usd = Money.new(1, 'USD')
      one_euro = Money.new(1,'EURO')
      sum = one_usd + one_euro
      expect( sum.currency.to_s ).to eq("USD")
      expect( sum.amount.round(2)).to eq (2.11)
    end

    it "can find difference of money in same currency" do
      one_usd = Money.new(1, 'USD')
      one_usd_1 = Money.new(1,'USD')
      sum = one_usd - one_usd 
      expect( sum.currency ).to eq('USD')
      expect( sum.amount.round(2) ).to eq(0.00)
    end

    it "can find difference of money in different currencies" do
      Money.conversion_rates('USD', {'EURO'=> 0.9})
      one_usd = Money.new(1, 'USD')
      one_euro = Money.new(1,'EURO')
      sum =  one_euro - one_usd
      expect( sum.currency ).to eq('EURO')
      expect( sum.amount.round(2) ).to eq(0.1)
    end

    it "can multiply an amount by a number" do
      one_usd = Money.new(1, 'USD')
      res = one_usd * 5
      expect(res.currency).to eq('USD')
      expect(res.amount).to eq(5)
    end

    it "can divide an amount by a number" do
      one_usd = Money.new(5, 'USD')
      res = one_usd / 5
      expect(res.currency).to eq('USD')
      expect(res.amount).to eq(1)
    end

    it 'checks if objects with same currency are equal' do
      Money.conversion_rates('USD', {'EURO'=> 1.11})
      one_euro = Money.new(1, 'EURO')
      one_euro_1 = Money.new(1, 'EURO')
      expect(one_euro == one_euro_1 ).to be_truthy
      expect(one_euro == one_euro ).to be_truthy
    end

    it 'checks if objects with different currency are equal' do
      Money.conversion_rates('USD', {'EURO'=> 0.9})
      one_euro = Money.new(1, 'EURO')
      one_usd = Money.new(1, 'USD')
      one_dollar_and_ten_cents = Money.new(1.11, 'USD')
      expect(one_euro == one_dollar_and_ten_cents ).to be_truthy
      expect(one_usd == one_euro ).to be_falsey
    end

    it 'can compare different objects with equal currency' do
      one_euro = Money.new(1, 'EURO')
      two_euro = Money.new(2, 'EURO')
      puts one_euro <= two_euro
      expect(one_euro <= two_euro).to be_truthy
      expect(two_euro > one_euro).to be_truthy
    end

    it 'can compare different objects with diffrent currency' do
      Money.conversion_rates('USD', {'EURO'=> 0.9})
      one_euro = Money.new(1, 'EURO')
      five_dollars = Money.new(5, 'Usd')
      expect(one_euro < five_dollars).to be_truthy
      expect(five_dollars >= one_euro ).to be_truthy
    end

  end


end