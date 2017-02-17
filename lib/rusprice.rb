require "rusprice/version"

module RusPrice
  RUBLE = "рубль"
  PENNY = 'копейка'

  def rusprice()
    self_value = self
    self_value = self * (-1) if self.negative?
    dec_part = (self_value % 1).round(2)
    if (dec_part == 1.0)
      rub_part = (self_value - (self_value % 1)).to_i + 1
      kop_part = 0
    else
      rub_part = (self_value - (self_value % 1)).to_i
      kop_part = (dec_part * 100).to_i
    end
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
      if [11, 12, 13, 14].include?(number % 100)
        'рублей'
      elsif (number % 10 == 1)
        'рубль'
      elsif [2, 3, 4].include?(number % 10)
        'рубля'
      else
        'рублей'
      end
    elsif kind == 'копейка'
      if [11, 12, 13, 14].include?(number % 100)
        'копеек'
      elsif (number % 10 == 1)
        'копейка'
      elsif [2, 3, 4].include?(number % 10)
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
