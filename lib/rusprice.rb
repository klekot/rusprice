require "rusprice/version"

module RusPrice
  RUBLE = "рубль"
  PENNY = 'копейка'

  def rusprice()
    self_value = self
    self_value = self * (-1) if self.negative?
    dec_part = (self_value % 1).round(2)
    rub_part = (self_value - (self_value % 1)).to_i
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

class Numeric
  include RusPrice
end
