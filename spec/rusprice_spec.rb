require 'spec_helper'

RSpec.describe RusPrice do
  context 'has a version number' do
    it{ expect(RusPrice::VERSION).not_to be nil }
  end

  context 'inverts negative price to positive one' do
    it{ expect(-1.rusprice).to eq('1 рубль') }
    it{ expect(-1.rp).to eq('1 рубль') }
    it{ expect(-1001.ruspace).to eq('1 001 рубль') }
    it{ expect(-1001.01.rushort).to eq('1 001 руб. 1 коп.') }
  end

  context 'fix problem 999' do
    it{ expect(0.999.rusprice).to eq('1 рубль') }
    it{ expect(0.999.rp).to eq('1 рубль') }
    it{ expect(9999.999.ruspace).to eq('10 000 рублей') }
    it{ expect(9999.999.rushort).to eq('10 000 руб.') }
  end

  # what's about 'рубли'?
  context 'when last number is 1 then \'рубль\'' do
    it{ expect(1.rusprice).to eq('1 рубль') }
    it{ expect(1.rp).to eq('1 рубль') }
    it{ expect(1001.ruspace).to eq('1 001 рубль') }
    it{ expect(1001.rushort).to eq('1 001 руб.') }
  end

  context 'when last number is 2 or 3 or 4 then \'рубля\'' do
    (2..4).each do |number|
      it{ expect(number.rusprice).to eq(number.to_s + ' рубля') }
      it{ expect(number.rp).to eq(number.to_s + ' рубля') }
      it{ expect((1000 + number).ruspace).to eq('1 00' + number.to_s + ' рубля') }
      it{ expect((1000 + number).rushort).to eq('1 00' + number.to_s + ' руб.') }
    end
  end

  context 'when last number is 0, 5, 6, 7, 8, 9, 11, 12, 13, 14 then \'рублей\'' do
    [0, 5, 6, 7, 8, 9, 11, 12, 13, 14].each do |number|
      prefix     = number.to_s.length == 1 ? '1 00' : '10 0'
      prefix_num = number.to_s.length == 1 ? 1000 : 10000
      it{ expect(number.rusprice).to eq(number.to_s + ' рублей') }
      it{ expect(number.rp).to eq(number.to_s + ' рублей') }
      it{ expect((prefix_num + number).ruspace).to eq(prefix + number.to_s + ' рублей') }
      it{ expect((prefix_num + number).rushort).to eq(prefix + number.to_s + ' руб.') }
    end
  end

  # And what's about 'копейки'?
  context 'when last number is 1 then \'копейка\'' do
    it{ expect(0.01.rusprice).to eq('1 копейка') }
    it{ expect(0.01.rp).to eq('1 копейка') }
    it{ expect(0.01.ruspace).to eq('1 копейка') }
    it{ expect(0.01.rushort).to eq('1 коп.') }
  end

  context 'when last number is 2 or 3 or 4 then \'копейки\'' do
    (2..4).each do |number|
      it{ expect((number / 100.0).rusprice).to eq(number.to_s + ' копейки') }
      it{ expect((number / 100.0).rp).to eq(number.to_s + ' копейки') }
      it{ expect((number / 100.0).ruspace).to eq(number.to_s + ' копейки') }
      it{ expect((number / 100.0).rushort).to eq(number.to_s + ' коп.') }
    end
  end

  context 'when last number is 5, 6, 7, 8, 9, 11, 12, 13, 14 then \'копеек\'' do
    [5, 6, 7, 8, 9, 11, 12, 13, 14].each do |number|
      it{ expect((number / 100.0).rusprice).to eq(number.to_s + ' копеек') }
      it{ expect((number / 100.0).rp).to eq(number.to_s + ' копеек') }
      it{ expect((number / 100.0).ruspace).to eq(number.to_s + ' копеек') }
      it{ expect((number / 100.0).rushort).to eq(number.to_s + ' коп.') }
    end
  end

  context 'when last number is 0 and number in range from 1 to 9 at left then \'копеек\'' do
    (1..9).each do |number|
      it{ expect((number / 10.0).rusprice).to eq(number.to_s + '0 копеек') }
      it{ expect((number / 10.0).rp).to eq(number.to_s + '0 копеек') }
      it{ expect((number / 10.0).ruspace).to eq(number.to_s + '0 копеек') }
      it{ expect((number / 10.0).rushort).to eq(number.to_s + '0 коп.') }
    end
  end

  context 'when first parameter is present then ruble part of price must be separated by its value' do
    it{ expect(1234567890.98.rusprice ' ').to eq('1 234 567 890 рублей 98 копеек') }
    it{ expect(1234567890.98.rusprice '_').to eq('1_234_567_890 рублей 98 копеек') }
  end

  context 'when second parameter is present' do
    it{ expect(1234567890.98.rusprice ' ', true).to eq('1 234 567 890 руб. 98 коп.') }
  end
end
