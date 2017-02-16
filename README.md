# RusPrice

Гем позволяет преобразовать число, представляющее некую цену в строку вида "5 рублей 10 копеек". Форма слов "рубль" и "копейка" будет изменена согласно правилам русского языка в зависимости от данного числа.
Модуль с методом "rusprice" добавляется в класс Numeric и может быть вызван на любом числе (см. "Примеры использования").
####Примечание:
 - Отрицательное число будет преобразовано в положительное;
 - Дробная часть будет округлена до двух знаков (используется метод "Float#round");
 - Числа 0 и 0.0 преобразуются к строке "0 рублей";
 - Число 0.001 преобразуются к строке "0 рублей";
 - Число 0.005 преобразуются к строке "1 копейка".

## Установка

Добавьте следующую строку в Gemfile:

```ruby
gem 'rusprice'
```

Потом выполните команду:

    $ bundle

Вы также можете установить rusprice в свою систему:

    $ gem install rusprice

## Примеры использования
```ruby
123.45.rusprice
# "123 рубля 45 копеек"

98.rusprice
# "98 рублей"

0.72.rusprice
# "72 копейки"
```

## Лицензия

Этот гем распространяется по [лицензии MIT](http://opensource.org/licenses/MIT).
