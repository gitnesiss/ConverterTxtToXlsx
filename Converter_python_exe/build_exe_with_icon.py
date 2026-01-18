import subprocess
import sys
import os
from pathlib import Path

def build_with_custom_icon():
    print("Создание EXE с кастомной иконкой...")
    
    # Путь к иконке
    icon_path = "icon.ico"
    
    if not os.path.exists(icon_path):
        print(f"❌ Иконка {icon_path} не найдена!")
        print("Создайте icon.ico или скачайте готовую")
        return
    
    cmd = [
        sys.executable, "-m", "PyInstaller",
        "--name=ConverterTxtToExcel",
        "--onefile",
        "--windowed",
        "--noconsole",
        "--clean",
        f"--icon={icon_path}",  # Указываем иконку
        "--add-data=icon.ico;.",  # Включаем иконку в сборку
        "converter_app.py"
    ]
    
    print(f"Используется иконка: {icon_path}")
    subprocess.run(cmd)
    
    # Создаем ярлык после сборки
    create_shortcut()
    
    print("\n✅ EXE создан с кастомной иконкой!")

def create_shortcut():
    """Создает ярлык на рабочем столе"""
    try:
        import winshell
        from win32com.client import Dispatch
        
        desktop = winshell.desktop()
        exe_path = os.path.abspath("dist/ConverterTxtToExcel.exe")
        shortcut_path = os.path.join(desktop, "Конвертер TXT в Excel.lnk")
        
        shell = Dispatch('WScript.Shell')
        shortcut = shell.CreateShortCut(shortcut_path)
        shortcut.Targetpath = exe_path
        shortcut.WorkingDirectory = os.path.dirname(exe_path)
        shortcut.IconLocation = exe_path  # Используем иконку из EXE
        shortcut.Description = "Конвертер текстовых файлов в Excel"
        shortcut.save()
        
        print(f"✅ Ярлык создан: {shortcut_path}")
        
    except ImportError:
        print("⚠ Не удалось создать ярлык автоматически")
        print("Создайте ярлык вручную из dist/ConverterTxtToExcel.exe")

if __name__ == "__main__":
    build_with_custom_icon()
    input("\nНажмите Enter для выхода...")