# Python Key Logger

- [Notes](#notes)
- [Python setup](#python-setup)
  - [Setup virtual environment](#setup-virtual-environment)
  - [Dependency installation](#dependency-installation)
- [Bash set up](#bash-setup)
  - [Bash scripts](#bash-scripts)
- [Building the application](#building-the-application)

## Notes

If you are using Windows, then it is recommended that you use the Git Bash or WSL terminal to run the commands listed in this documentation.

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
pip install -r requirements.txt

#-------------------------------------------------------------------------------
# Create requirements
pip freeze > requirements.txt
```

## Bash setup

This project uses some automated bash scripts to aid in setup and building of the application.

```bash
# Change mod of init script
chmod +x ./bash/init.sh

# Run the init command
# The init script will make sure that all the script files are available for execution
./bash/init.sh
#-------------------------------------------------------------------------------
```

### Bash scripts

The following are a number od bash scripts and a description of what they do.

Please note that on Windows, the installation of the ImageMagick package may be required.

To view help for this see [ImageMagick.md](./ImageMagick.md)

```bash
# Create the icon from png
# This script will convert the icon.png file within the assets directory
# into a icon.icns file that can be used to set the image of the application when built
./bash/make_icon.sh

# Build the executable
# This script will build the application into an executable that can be run on
# Window MacOS or Linux
./bash/build.sh
```

## Building the application

Running the build.sh file will build the application on your system for the relevant OS.

The executable will be created in the dist directory, and can be run via the terminal or by double-clicking the exe within the file explorer.
