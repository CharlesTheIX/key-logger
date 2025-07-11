# Python Key Logger

- [Notes](#notes)
- [Python setup](#python-setup)
  - [Setup virtual environment](#setup-virtual-environment)
  - [Dependency installation](#dependency-installation)
- [Building the application](#building-the-application)

## Notes

If you are using Windows, then it is recommended that you use the Git Bash or WSL terminal to run the commands listed in this documentation.

The `history.csv` file will be saved at the following pathname:

```bash
# Windows
~/AppData/Local/KeyLogger/history.csv

# MacOs and Linux
~/.KeyLogger/history.csv
```

## Python setup

This project assumes that python (or python3) and pip are already installed on your local machine.

When you see a python or pip command, it could also be a python 3 or pip3 command respectively.

### Setup virtual environment

```bash
# Set up virtual python environment
python -m venv venv

#-------------------------------------------------------------------------------
# Enter the virtual environment
# Mac / Linux
source ./venv/bin/activate

# Windows - command prompt
source ./venv/Scripts/activate

# Window - powershell
source .\venv\Scripts\Activate.ps1

#-------------------------------------------------------------------------------
# To deactivate the environment
deactivate
```

### Dependency installation

This application uses the following main dependencies:

- pynput
- pyinstaller

```bash
# Install new dependencies
pip install [DEPENDENCY_NAME]

# Install project dependencies
pip install -r requirements_[OS].txt

#-------------------------------------------------------------------------------
# Create requirements
pip freeze > requirements_[OS].txt
```

## Development

To expand this project you can create other files and import them.

Please keep the requirements files up-to-date as per OS, [see here](#dependency-installation) for more information.

To run the python script in a 'development mode', run the following command:

```bash
python ./main.py
```

Be aware of the following:

```python
# If you make a sub directory then that sub directory will need an
# __init__.py in the directory to declare the directory as a module

#-------------------------------------------------------------------------------
# Import the files from the module
from [MODULE_NAME / DIRE_NAME] import [FILE_NAME]
# eg.
from src import logger

#-------------------------------------------------------------------------------
# To use functions with the imported file:
[FILE_NAME].[FUNCTION_NAME]
#eg.
logger.read_file()
```

## Building the application

This project uses an automated bash script to aid in the building of the application.

Please note that on Windows, the installation of the ImageMagick package may be required.

To view help for this see [ImageMagick.md](./ImageMagick.md).

Running the build.sh file will build the application on your system for the relevant OS.

The executable will be created in the dist directory, and can be run via the terminal or by double-clicking the exe within the file explorer.

This application will run in the background, therefore to stop it you will need to end the task via the OS task manager.

```bash
# Change mod of build script
chmod +x ./_bash.sh

# Build the executable
# This script will build the application into an executable that can be run on
# Window MacOS or Linux
# This function will automatically create the icon for the application based on
# the png files in the assets directory - update the file keeping the file name
# depending on your OS
./_build.sh
```

## Clean up

To clean up the project ie remove the build and dist files, run the floowing code:

```bash
# Change mod of clean script
chmod +x ./_clean.sh

# Clean the repository build and distribution files
# This file will run through the build, dist, created icon and spec files(s)
# and remove them from the repo, leaving a fresh state to re-run the build script
./_clean.sh
```
