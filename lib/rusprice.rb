require 'rusprice/version'

module RusPrice
  RUBLE = 'рубль'.freeze
  PENNY = 'копейка'.freeze

  def rusprice (sep = '', short = false)
    self_value = self >= 0 ? self : self * -1
    dec_part = (self_value % 1).round(2)
    if dec_part == 1.0
      rub_part = (self_value - (self_value % 1)).to_i + 1
      kop_part = 0
    else
      rub_part = (self_value - (self_value % 1)).to_i
      kop_part = (dec_part * 100).to_i
    end
    rub_case = short ? 'руб.' : cases(rub_part, RUBLE)
    kop_case = short ? 'коп.' : cases(kop_part, PENNY)
    if kop_part.zero?
      "#{spaces_on rub_part, sep} #{rub_case}"
    elsif rub_part.zero?
      "#{kop_part} #{kop_case}"
    else
      "#{spaces_on rub_part, sep} #{rub_case} #{kop_part} #{kop_case}"
    end
  end

  # Just shortcut for method "rusprice"
  def rp (sep = '', short = false)
    rusprice sep, short
  end

  # "rusprice" with whitespaces by default
  def ruspace (short = false)
    rusprice ' ', short
  end

  # "rusprice" with "руб." and "коп." by default
  def rushort (sep = ' ')
    rusprice sep, true
  end

  # "rusprice" with whitespaces and "руб." and "коп." by default
  def rpss
    rusprice ' ', true
  end

  private

  def cases (number, kind)
    if [11, 12, 13, 14].include?(number % 100)
      kind == 'рубль' ? 'рублей' : 'копеек'
    elsif number % 10 == 1
      kind == 'рубль' ? 'рубль' : 'копейка'
    elsif [2, 3, 4].include?(number % 10)
      kind == 'рубль' ? 'рубля' : 'копейки'
    else
      kind == 'рубль' ? 'рублей' : 'копеек'
    end
  end

  def spaces_on(number, sep)
    number.to_s.tap do |s|
      :go while s.gsub!(/^([^.]*)(\d)(?=(\d{3})+)/, "\\1\\2#{sep}")
    end
  end
end


class Numeric
  include RusPrice
end
