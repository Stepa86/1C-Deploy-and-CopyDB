# 1C-Deploy-and-CopyDB
Набор скриптов для деплоя базы 1С через хранилище и копирование через sql-бекап одной базы в другую

# Что это?

Подробнее в статье http://infostart.ru/public/617478/

Есть 2 основных оскрипта [deploy.os](/src/deploy.os) и [CopyBase.os](/src/CopyBase.os)  

1. Оба читают параметры из json файлов
2. Выполняют их тестирование - что к хранилищу коннектится, что кластер отвечает и что доступ к скулю получен.
3. [CopyBase.os](/src/CopyBase.os) копирует базу данных из другой базы. Типа когда захотелось получить свежие данные из рабочей в свою. Проверяет, что соединений с указанной базой нет, делает скульный бекап источника, разворачивает в указанную базу, отрубает старое хранилище и подрубает новое, обновляет базу. Выглядит так

![CopyDB](/images/CopyDB.png)

4. [deploy.os](/src/deploy.os) выполняет деплой в РБ. С помощью деплойки блокирует и выгоняет пользователей, обновляется из хранилища и запускает миграцию. Выглядит так 

![deploy](/images/Deploy.png)

5. [deploy.os](/src/deploy.os) так же можно запустить только для динамического обновления

Отличия от [deployka](https://github.com/oscript-library/deployka):

* Есть тест параметров, а то я раз 5 перезапускал скрипт в первый раз довводя правильные параметры. Особенно обидно когда крашится на последнем этапе.
* Весь код на оскрипте, из батника только вызов. Если кому то в оскрипте удобнее, чем в bat разрабатывать/отлаживать
* Есть выполнение бекапов, а недавняя история с гитлабом убедила меня, что лишний бекап никогда не помешает, даже когда есть 5 альтернативных планов
* Более удобное изменение параметров через файлы. Любой параметр указывается в одном и только в одном месте

# Используемые проекты

* Проект основан на [oscript.io](oscript.io)
* /src/deploy.os основана на библиотеке [deployka](https://github.com/oscript-library/deployka). Для нужд проекта пришлось добавить новую функциональность, которая несколько противоречет основной идее библиотеки, и поэтому она не было модифицирована через PR. Включена в этот проект. /src/lib/deployka_m 
 
* Используются библиотеки [cmdline](https://github.com/oscript-library/cmdline), [logos](https://github.com/oscript-library/logos), [v8runner](https://github.com/oscript-library/v8runner), [1commands](https://github.com/oscript-library/1commands), [readparams](https://github.com/oscript-library/readparams) и [progbar](https://github.com/oscript-library/progbar). Они должны быть заранее скачены и установлены через [opm](https://github.com/oscript-library/opm)
```cmd
opm update opm
opm install cmdline
opm install logos
opm install v8runner
opm install 1commands
opm install readparams
opm install progbar
opm update -all
```

# Навигация
В src весь код, в bin пример
