# Задача 

Нужно создать мобильное приложение “Пора в путешествие” с двумя экранами.

Первый экран представляет из себя список авиаперелетов.

Каждая ячейка списка должна содержать:

Город отправления.
Город прибытия.
Дата отправления.
Дата возвращения.
Цена в рублях.
Иконка “Лайк” (имеет два состояния и означает лайкнул ли пользователь данный авиаперелет).

Второй экран - это детализация перелета с кнопкой “Лайк”.
Второй экран открывается при выборе одной из ячеек первого экрана. Должна быть возможность вернуться к первому экрану назад.

Второй экран содержит данные по выбранному перелету (город отправления, город прибытия, дата отправления, дата возвращения, цена в рублях) и кнопку “Лайк”.

Кнопка лайк имеет два состояния:

Перелет нравится.
Перелет не нравится.

# Реализация:

-Архитектура MVC

-API Response

-Получение информации о действиях на разных экранах через клоужеры

```
cell.didTapLike = { isLiked in
    var ticket = self.tickets[indexPath.row
    ticket.isLiked = isLiked
    self.tickets[indexPath.row] = ticket
    tableView.reloadData()
}
```

-Имеется индикатор загрузки 
