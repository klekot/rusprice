#require "rusprice/version"

module RusPrice
  class Converter
    RUBLE = "рубль"
    PENNY = 'копейка'

    attr_accessor :price

    def initialize(price = 0)
      begin
        raise ArgumentError, "Only Numeric accepted!" unless price.is_a? Numeric
        @price = price
      rescue => exception
        puts exception.message
      end
    end

    def russify()
      @price = @price * (-1) if @price < 0
      dec_part = (@price % 1).round(2)
      rub_part = (@price - (@price % 1)).to_i
      kop_part = (dec_part * 100).to_i
      rub_case = cases rub_part, RUBLE
      kop_case = cases kop_part, PENNY
      unless kop_part == 0
        unless rub_part == 0
          output = "#{rub_part} #{rub_case} #{kop_part} #{kop_case}"
        else
          output = "#{kop_part} #{kop_case}"
        end
      else
        output = "#{rub_part} #{rub_case}"
      end
    end

    private

    def cases (number, kind)
      if kind == 'рубль'
        if (number % 100 == 11) || (number % 100 == 12) || (number % 100 == 13) || (number % 100 == 14)
          'рублей'
        elsif (number % 10 == 1)
          'рубль'
        elsif (number % 10 == 2) || (number % 10 == 3) || (number % 10 == 4)
          'рубля'
        else
          'рублей'
        end
      elsif kind == 'копейка'
        if (number == 11) || (number == 12) || (number == 13) || (number == 14)
          'копеек'
        elsif (number % 10 == 1)
          'копейка'
        elsif (number % 10 == 2) || (number % 10 == 3) || (number % 10 == 4)
          'копейки'
        else
          'копеек'
        end
      else
        ''
      end
    end
  end
end
