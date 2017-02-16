require "spec_helper"

RSpec.describe RusPrice do
  it "has a version number" do
    expect(RusPrice::VERSION).not_to be nil
  end

  #what's about 'рубли'?
  it "when last number is 1 then 'рубль'" do
    number = 1
    price = RusPrice::Converter.new number
    expect(price.russify).to eq(number.to_s + " рубль")
  end

  it "when last number is 2 or 3 or 4 then 'рубля'" do
    (2..4).each do |number|
      price = RusPrice::Converter.new number
      expect(price.russify).to eq(number.to_s + " рубля")
    end
  end

  it "when last number is 0, 5, 6, 7, 8, 9, 11, 12, 13, 14 then 'рублей'" do
    num_array = [0, 5, 6, 7, 8, 9, 11, 12, 13, 14]
    num_array.each do |number|
      price = RusPrice::Converter.new number
      expect(price.russify).to eq(number.to_s + " рублей")
    end
  end

  # And what's about 'копейки'?
  it "when last number is 1 then 'копейка'" do
    number = 1
    price = RusPrice::Converter.new number / 100.0
    expect(price.russify).to eq(number.to_s + " копейка")
  end

  it "when last number is 2 or 3 or 4 then 'копейки'" do
    (2..4).each do |number|
      price = RusPrice::Converter.new number / 100.0
      expect(price.russify).to eq(number.to_s + " копейки")
    end
  end

  it "when last number is 0, 5, 6, 7, 8, 9, 11, 12, 13, 14 then 'копеек'" do
    num_array = [0, 5, 6, 7, 8, 9, 11, 12, 13, 14]
    num_array.each do |number|
      price = RusPrice::Converter.new number / 100.0
      unless number == 0 && price != 0
        expect(price.russify).to eq(number.to_s + " копеек")
      else
        expect(price.russify).to eq(number.to_s + " рублей")
      end
    end
  end

  it "when last number is 0 and number in range from 1 to 9 at left then 'копеек'" do
    (1..9).each do |number|
      price = RusPrice::Converter.new number / 10.0
      expect(price.russify).to eq(number.to_s + "0 копеек")
    end
  end
end
