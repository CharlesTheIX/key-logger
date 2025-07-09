```bash
# Set up virtual python environment
python -m venv venv
source ./venv/bin/activate

# To deactivate the environment
deactivate

# Install new dependencies
pip install DEPENDENCY_NAME

# Install project dependencies
pip install -r requirements.txt

# Create requirements
pip freeze > requirements.txt

# Create executable
pyinstaller --onefile --windowed --name key-logger --icon=assets/icon.icns main.py

# Create the icon from png
chmod +x ./bash/make_icon.sh
./bash/make_icon.sh

# Build the executable
chmod +x ./bash/build.sh
./bash/build.sh
```
