require 'spec_helper'

RSpec.describe RusPrice do
  context 'has a version number' do
    it{ expect(RusPrice::VERSION).not_to be nil }
  end

  context 'inverts negative price to positive one' do
    it{ expect(-1.rusprice).to eq('1 рубль') }
  end

  context 'fix problem 999' do
    it{ expect(0.999.rusprice).to eq('1 рубль') }
  end

  # what's about 'рубли'?
  context 'when last number is 1 then \'рубль\'' do
    it{ expect(1.rusprice).to eq('1 рубль') }
  end

  context 'when last number is 2 or 3 or 4 then \'рубля\'' do
    (2..4).each do |number|
      it{ expect(number.rusprice).to eq(number.to_s + ' рубля') }
    end
  end

  context 'when last number is 0, 5, 6, 7, 8, 9, 11, 12, 13, 14 then \'рублей\'' do
    [0, 5, 6, 7, 8, 9, 11, 12, 13, 14].each do |number|
      it{ expect(number.rusprice).to eq(number.to_s + ' рублей') }
    end
  end

  # And what's about 'копейки'?
  context 'when last number is 1 then \'копейка\'' do
    it{ expect(0.01.rusprice).to eq('1 копейка') }
  end

  context 'when last number is 2 or 3 or 4 then \'копейки\'' do
    (2..4).each do |number|
      it{ expect((number / 100.0).rusprice).to eq(number.to_s + ' копейки') }
    end
  end

  context 'when last number is 5, 6, 7, 8, 9, 11, 12, 13, 14 then \'копеек\'' do
    [5, 6, 7, 8, 9, 11, 12, 13, 14].each do |number|
      it{ expect((number / 100.0).rusprice).to eq(number.to_s + ' копеек') }
    end
  end

  context 'when last number is 0 and number in range from 1 to 9 at left then \'копеек\'' do
    (1..9).each do |number|
      it{ expect((number / 10.0).rusprice).to eq(number.to_s + '0 копеек') }
    end
  end
end
