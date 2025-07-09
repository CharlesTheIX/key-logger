from src import logger
from pynput import keyboard

current_keys = set()

def monitor_keys() -> None:
    global current_key

    def on_key_press(key: keyboard.Key) -> None:
        logger.on_press(key)
        current_keys.add(key)

    def on_key_release(key: keyboard.Key) -> None:
        current_keys.discard(key)

    with keyboard.Listener(on_press=on_key_press, on_release=on_key_release) as listener:
        listener.join()


if __name__ == "__main__":
    monitor_keys()
