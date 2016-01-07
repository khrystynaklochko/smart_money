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
      expect(euro.amount).to eq(110.round(2))
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

end