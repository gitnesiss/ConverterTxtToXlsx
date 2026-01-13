@echo off
title Конвертер TXT в Excel
echo ========================================
echo     КОНВЕРТЕР TXT В EXCEL/CSV
echo ========================================
echo.
echo Запуск приложения...

REM Переходим в папку скрипта
cd /d "%~dp0"

REM Проверяем виртуальное окружение
if not exist "venv\Scripts\python.exe" (
    echo ❌ Виртуальное окружение не найдено!
    echo Установите зависимости командой:
    echo pip install -r requirements.txt
    pause
    exit /b 1
)

REM Запускаем приложение
echo ✓ Запускаем приложение...
echo.
"venv\Scripts\python.exe" "converter_app.py"

echo.
echo ========================================
echo Приложение завершено.
echo ========================================
pause