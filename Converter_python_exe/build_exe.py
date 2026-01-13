import subprocess
import sys

def build_exe():
    print("Создание EXE файла без консоли...")
    
    cmd = [
        sys.executable, "-m", "PyInstaller",
        "--name=Конвертер_txt_в_Excel",
        "--onefile",
        "--windowed",  # Ключевой параметр: без консоли
        "--noconsole", # Дополнительное подтверждение
        "--clean",
        "--distpath=dist",
        "converter_app.py"
    ]
    
    subprocess.run(cmd)
    print("\n✅ Готово! EXE файл в папке 'dist'")

if __name__ == "__main__":
    build_exe()