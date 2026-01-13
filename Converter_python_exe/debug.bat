@echo off
echo Запуск с отладкой...
echo.
python converter_app.py
echo.
echo Программа завершилась с кодом: %errorlevel%
pause