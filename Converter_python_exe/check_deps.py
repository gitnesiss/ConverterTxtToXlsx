import sys
import os

def check_environment():
    print("="*60)
    print("ПРОВЕРКА ОКРУЖЕНИЯ")
    print("="*60)
    
    print(f"1. Python версия: {sys.version}")
    print(f"2. Python путь: {sys.executable}")
    print(f"3. Рабочая папка: {os.getcwd()}")
    
    print("\n4. Проверка PySide6:")
    try:
        from PySide6 import QtCore
        print(f"   ✅ PySide6 версия: {QtCore.__version__}")
        print(f"   ✅ Qt версия: {QtCore.qVersion()}")
    except Exception as e:
        print(f"   ❌ Ошибка: {e}")
    
    print("\n5. Проверка openpyxl:")
    try:
        import openpyxl
        print(f"   ✅ openpyxl версия: {openpyxl.__version__}")
    except Exception as e:
        print(f"   ❌ Ошибка: {e}")
    
    print("\n6. Проверка chardet:")
    try:
        import chardet
        print(f"   ✅ chardet версия: {chardet.__version__}")
    except Exception as e:
        print(f"   ❌ Ошибка: {e}")
    
    print("\n7. Проверка PATH:")
    paths = sys.path[:10]  # Первые 10 путей
    for i, path in enumerate(paths, 1):
        print(f"   {i}. {path}")
    
    print("\n8. Переменные окружения:")
    print(f"   PYTHONPATH: {os.environ.get('PYTHONPATH', 'не установлен')}")
    
    print("\n" + "="*60)
    
    input("Нажмите Enter для выхода...")

if __name__ == "__main__":
    check_environment()