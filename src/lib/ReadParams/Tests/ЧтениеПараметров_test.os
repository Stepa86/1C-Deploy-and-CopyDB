#Использовать ".."
#Использовать asserts
#Использовать fs
#Использовать tempfiles


Перем юТест;
Перем ВременныйКаталог;

Процедура Инициализация()
	
КонецПроцедуры

Функция ПолучитьСписокТестов(Тестирование) Экспорт
	
	юТест = Тестирование;
	
	СписокТестов = Новый Массив;
	СписокТестов.Добавить("Тест_ОшибкаЧтенияНесуществующегоФайла");
	СписокТестов.Добавить("Тест_ПрочитатьФайлПараметров");
	СписокТестов.Добавить("Тест_ПрочитатьМассивФайловПараметров");
	СписокТестов.Добавить("Тест_ПрочитатьФайлыПараметровЧерезСсылки");
	СписокТестов.Добавить("Тест_ПрочитатьФайлыПараметровЧерезОтносительныеСсылки");
	СписокТестов.Добавить("Тест_Подстановка");
	СписокТестов.Добавить("Тест_ПрочитатьФайлИзТекущегоКаталога");

	Возврат СписокТестов;
	
КонецФункции

Процедура ПередЗапускомТеста() Экспорт
	ВременныйКаталог = ВременныеФайлы.СоздатьКаталог();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	Если ЗначениеЗаполнено( ВременныйКаталог) Тогда
		ВременныеФайлы.УдалитьФайл( ВременныйКаталог );
		ВременныйКаталог = "";
	КонецЕсли;
КонецПроцедуры

Процедура Тест_ОшибкаЧтенияНесуществующегоФайла() Экспорт
	
	файлПараметров = ОбъединитьПути( ВременныйКаталог, "НесуществующийФайл.json");

	ошибкиЧтения = Неопределено;

	прочитанныеПараметры = ЧтениеПараметров.Прочитать( файлПараметров, ошибкиЧтения );

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 0, "Прочитанных параметров должно быть 0");

	Утверждения.ПроверитьРавенство( ТипЗнч(ошибкиЧтения), Тип("Соответствие"), "Ошибки чтения должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( ошибкиЧтения.Количество(), 1, "Должна быть одна ошибка чтения");
	Утверждения.ПроверитьРавенство( ошибкиЧтения[файлПараметров], "Не существует", "Ошибка чтения должна быть ""Не существует""");
		
КонецПроцедуры

Процедура Тест_ПрочитатьФайлПараметров() Экспорт
	
	файлПараметров = ОбъединитьПути( ВременныйКаталог, "testParam.json");

	записьТекста = Новый ЗаписьТекста(файлПараметров);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 100, ""парам.Строка"": ""100"", ""парам.Булево"": true}" );
	ЗаписьТекста.Закрыть();

	ошибкиЧтения = Неопределено;

	прочитанныеПараметры = ЧтениеПараметров.Прочитать( файлПараметров, ошибкиЧтения );

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 3, "Прочитанных параметров должно быть 3");

	Утверждения.ПроверитьРавенство( ТипЗнч(ошибкиЧтения), Тип("Соответствие"), "Ошибки чтения должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( ошибкиЧтения.Количество(), 0, "Ошибок чтения быть не должно");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число"], 100, "Должно быть парам.Число = 100");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка"], "100", "Должно быть парам.Строка = ""100""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево"], Истина, "Должно быть парам.Булево = Истина");
	
КонецПроцедуры

Процедура Тест_ПрочитатьМассивФайловПараметров() Экспорт
	
	файлПараметров1 = ОбъединитьПути( ВременныйКаталог, "testParam1.json");
	файлПараметров2 = ОбъединитьПути( ВременныйКаталог, "testParam2.json");
	файлПараметров3 = ОбъединитьПути( ВременныйКаталог, "testParam3.json");

	записьТекста = Новый ЗаписьТекста(файлПараметров1);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 1, ""парам.Строка"": ""1"", ""парам.Булево"": true}" );
	ЗаписьТекста.Закрыть();

	записьТекста = Новый ЗаписьТекста(файлПараметров2);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число2"": 2, ""парам.Строка2"": ""2"", ""парам.Булево2"": false}" );
	ЗаписьТекста.Закрыть();

	записьТекста = Новый ЗаписьТекста(файлПараметров3);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 3, ""парам.Строка"": ""3""}" );
	ЗаписьТекста.Закрыть();

	ошибкиЧтения = Неопределено;

	массивФайлов = Новый Массив;

	массивФайлов.Добавить( файлПараметров1 );
	массивФайлов.Добавить( Новый Файл( файлПараметров2) );
	массивФайлов.Добавить( Новый Структура("ТретийФайл", файлПараметров3) );

	прочитанныеПараметры = ЧтениеПараметров.Прочитать( массивФайлов, ошибкиЧтения );

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 6, "Прочитанных параметров должно быть 6");

	Утверждения.ПроверитьРавенство( ТипЗнч(ошибкиЧтения), Тип("Соответствие"), "Ошибки чтения должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( ошибкиЧтения.Количество(), 0, "Ошибок чтения быть не должно");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число"], 3, "Должно быть парам.Число = 3");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка"], "3", "Должно быть парам.Строка = ""3""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево"], Истина, "Должно быть парам.Булево = Истина");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число2"], 2, "Должно быть парам.Число = 2");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка2"], "2", "Должно быть парам.Строка = ""2""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево2"], Ложь, "Должно быть парам.Булево = Ложь");
	
КонецПроцедуры

Процедура Тест_ПрочитатьФайлыПараметровЧерезСсылки() Экспорт
	
	файлПараметров1 = ОбъединитьПути( ВременныйКаталог, "testParam1.json");
	файлПараметров2 = ОбъединитьПути( ВременныйКаталог, "testParam2.json");
	файлПараметров3 = ОбъединитьПути( ВременныйКаталог, "testParam3.json");

	записьТекста = Новый ЗаписьТекста(файлПараметров1);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 1, ""парам.Строка"": ""1"", ""парам.Булево"": true, ""ReadFile"": """ + ПутьВЗначениеJSON( файлПараметров2 ) + """}" );
	ЗаписьТекста.Закрыть();

	записьТекста = Новый ЗаписьТекста(файлПараметров2);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число2"": 2, ""парам.Строка2"": ""2"", ""парам.Булево2"": false, ""ReadFile"": """ + ПутьВЗначениеJSON( файлПараметров3 ) + """}" );
	ЗаписьТекста.Закрыть();

	записьТекста = Новый ЗаписьТекста(файлПараметров3);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 3, ""парам.Строка"": ""3""}" );
	ЗаписьТекста.Закрыть();

	ошибкиЧтения = Неопределено;

	прочитанныеПараметры = ЧтениеПараметров.Прочитать( файлПараметров1, ошибкиЧтения );

	Для каждого цЭлемент Из ошибкиЧтения Цикл

		Сообщить( цЭлемент.Ключ + ": " + цЭлемент.Значение );

	КонецЦикла;

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 7, "Прочитанных параметров должно быть 7");

	Утверждения.ПроверитьРавенство( ТипЗнч(ошибкиЧтения), Тип("Соответствие"), "Ошибки чтения должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( ошибкиЧтения.Количество(), 0, "Ошибок чтения быть не должно");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число"], 3, "Должно быть парам.Число = 3");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка"], "3", "Должно быть парам.Строка = ""3""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево"], Истина, "Должно быть парам.Булево = Истина");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число2"], 2, "Должно быть парам.Число = 2");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка2"], "2", "Должно быть парам.Строка = ""2""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево2"], Ложь, "Должно быть парам.Булево = Ложь");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["ReadFile"], файлПараметров3);
	
КонецПроцедуры

Процедура Тест_ПрочитатьФайлыПараметровЧерезОтносительныеСсылки() Экспорт
	
	файлПараметров1 = ОбъединитьПути( ВременныйКаталог, "testParam1.json");
	файлПараметров2 = ОбъединитьПути( ВременныйКаталог, "testParam2.json");
	файлПараметров3 = ОбъединитьПути( ВременныйКаталог, "testParam3.json");

	путь2 = ПутьВЗначениеJSON( ОбъединитьПути(".", "testParam2.json") );
	путь3 = ПутьВЗначениеJSON( ОбъединитьПути(".", "testParam3.json") );

	записьТекста = Новый ЗаписьТекста(файлПараметров1);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 1, ""парам.Строка"": ""1"", ""парам.Булево"": true, ""ReadFile"": """ + путь2 + """}" );
	ЗаписьТекста.Закрыть();

	записьТекста = Новый ЗаписьТекста(файлПараметров2);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число2"": 2, ""парам.Строка2"": ""2"", ""парам.Булево2"": false, ""ReadFile"": """ + путь3 + """}" );
	ЗаписьТекста.Закрыть();

	записьТекста = Новый ЗаписьТекста(файлПараметров3);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 3, ""парам.Строка"": ""3""}" );
	ЗаписьТекста.Закрыть();

	ошибкиЧтения = Неопределено;

	прочитанныеПараметры = ЧтениеПараметров.Прочитать( файлПараметров1, ошибкиЧтения );

	Для каждого цЭлемент Из ошибкиЧтения Цикл

		Сообщить( цЭлемент.Ключ + ": " + цЭлемент.Значение );

	КонецЦикла;

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 7, "Прочитанных параметров должно быть 7");

	Утверждения.ПроверитьРавенство( ТипЗнч(ошибкиЧтения), Тип("Соответствие"), "Ошибки чтения должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( ошибкиЧтения.Количество(), 0, "Ошибок чтения быть не должно");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число"], 3, "Должно быть парам.Число = 3");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка"], "3", "Должно быть парам.Строка = ""3""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево"], Истина, "Должно быть парам.Булево = Истина");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число2"], 2, "Должно быть парам.Число = 2");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка2"], "2", "Должно быть парам.Строка = ""2""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево2"], Ложь, "Должно быть парам.Булево = Ложь");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["ReadFile"], ОбъединитьПути(".", "testParam3.json"));
	
КонецПроцедуры

Функция ПутьВЗначениеJSON( Знач пПутьКФайлу )
	
	рез = СтрЗаменить( пПутьКФайлу, "\", "\\" );
	Возврат рез;

КонецФункции

Процедура Тест_Подстановка() Экспорт
	
	файлПараметров = ОбъединитьПути( ВременныйКаталог, "testParam.json");

	записьТекста = Новый ЗаписьТекста(файлПараметров);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 100,
	|""парам.Подстановка1"": ""999+%парам.Число%+%парам.Число%"",
	|""парам.Подстановка2"": ""0+%парам.Подстановка1%+%парам.Число%""
	|}" );
	ЗаписьТекста.Закрыть();

	ошибкиЧтения = Неопределено;

	прочитанныеПараметры = ЧтениеПараметров.Прочитать( файлПараметров, ошибкиЧтения );

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 3, "Прочитанных параметров должно быть 3");

	Утверждения.ПроверитьРавенство( ТипЗнч(ошибкиЧтения), Тип("Соответствие"), "Ошибки чтения должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( ошибкиЧтения.Количество(), 0, "Ошибок чтения быть не должно");
	
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число"], 100, "Должно быть парам.Число = 100");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Подстановка1"], "999+100+100", "Должно быть парам.Подстановка1 = ""999+100+100""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Подстановка2"], "0+999+100+100+100", "Должно быть парам.Подстановка2 = ""0+999+100+100+100""");
	
КонецПроцедуры

Процедура Тест_ПрочитатьФайлИзТекущегоКаталога() Экспорт
	
	файлПараметров = ОбъединитьПути( ТекущийКаталог(), "param_os.json");

	Утверждения.ПроверитьРавенство( фс.ФайлСуществует(файлПараметров), Ложь, "В текущем каталоге уже есть файл param_os.json");

	записьТекста = Новый ЗаписьТекста(файлПараметров);
	ЗаписьТекста.ЗаписатьСтроку( "{""парам.Число"": 100, ""парам.Строка"": ""100"", ""парам.Булево"": true}" );
	ЗаписьТекста.Закрыть();

	прочитанныеПараметры = ЧтениеПараметров.Прочитать();

	Утверждения.ПроверитьРавенство( ТипЗнч(прочитанныеПараметры), Тип("Соответствие"), "Прочитанные параметры должны быть с типом Соответствие");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры.Количество(), 3, "Прочитанных параметров должно быть 3");

	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Число"], 100, "Должно быть парам.Число = 100");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Строка"], "100", "Должно быть парам.Строка = ""100""");
	Утверждения.ПроверитьРавенство( прочитанныеПараметры["парам.Булево"], Истина, "Должно быть парам.Булево = Истина");
	
	УдалитьФайлы( файлПараметров );

КонецПроцедуры

