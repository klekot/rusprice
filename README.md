# RusPrice

Гем позволяет преобразовать число, представляющее некую цену в строку вида "5 рублей 10 копеек". Форма слов "рубль" и "копейка" будет изменена согласно правилам русского языка в зависимости от данного числа.

## Установка

Добавьте следующую строку в Gemfile:

```ruby
gem 'rusprice'
```

Потом выполните команду:

    $ bundle

Вы также можете установить rusprice в свою систему:

    $ gem install rusprice

### Примеры использования
```ruby
price = RusPrice::Converter.new 123.45
price.russify
# "123 рубля 45 копеек"

price = RusPrice::Converter.new 98
price.russify
# "98 рублей"

price = RusPrice::Converter.new 0.72
price.russify
# "72 копейки"
    ```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/klekot/rusprice. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
