# Key Logger - Python

## 📚 Table of Contents

- [Disclaimer](#⚠️-disclaimer)
- [Notes](#📝-notes)
- [Setup](#🔧-setup)
  - [Set Up Virtual Environment](#📦-set-up-virtual-environment)
  - [Install Dependencies](#🧩-dependency-installtion)
- [Development](#🛠️-development)
- [Building the Application](#🏗️-building-the-application)
- [Clean-up](#🧹-clean-up)

## ⚠️ Disclaimer

This software is intended strictly for educational purposes or authorized security testing on systems you own or have explicit permission to monitor.

Unauthorized use of a keylogger may violate privacy laws, computer misuse laws, or company policies.
By using this project, you agree that the developers and contributors are not responsible for any misuse or damage resulting from its use.

Never use this software to record or monitor activity on a device you do not own or have explicit legal permission to control. Always comply with local laws and regulations.

## 📝 Notes

If you're using **Windows**, it's recommended to use **Git Bash** or **WSL** for running the shell commands in this documentation.

The `history.csv` file will be saved at:

```bash
# Windows
~/AppData/Local/KeyLogger/history.csv

# macOS / Linux
~/.KeyLogger/history.csv
```

## 🔧 Setup

This project assumes that python (or python3) and pip are already installed on your local machine.

When you see a python or pip command, it could also be a python 3 or pip3 command respectively.

### 📦 Setup virtual environment

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

### 🧩 Dependency installation

This application uses the following main dependencies:

- pynput
- pyinstaller

```bash
# Install new dependencies
pip install [DEPENDENCY_NAME]

# Install project dependencies
pip install -r ./requirements/[OS].txt

#-------------------------------------------------------------------------------
# Create requirements
pip freeze > ./requirements/[OS].txt

#-------------------------------------------------------------------------------
# Install dependencies with bash
chmod +x ./bash.sh
./bash.sh install
```

## 🛠️ Development

To expand this project you can create other files and import them.

Please keep the requirements files up-to-date as per OS, [see here](#dependency-installation) for more information.

To run the python script in a 'development mode', run the following command:

```bash
python ./main.py
```

## 🏗️ Building the application

This project uses an automated bash script to aid in the building of the application.

Please note that on Windows, the installation of the ImageMagick package may be required.

> ### 🧰 ImageMagick Installation - Windows
>
> Download ImageMagick for Windows, [Go to the official site](https://imagemagick.org/script/download.php#windows)
> Choose "ImageMagick-7.x.x-Q16-HDRI-x64-dll.exe"
> Make sure to check:
>
> - Add application directory to your system PATH
> - Install legacy utilities (if you want the convert command)
>
> ### 🧰 ImageMagick Installation - Linux (Ubuntu/Debian)
>
> ```bash
> sudo apt update
> sudo apt install imagemagick
> ```

Running the bash.sh file with the `build` argument will build the application on your system for the relevant OS.

The executable will be created in the dist directory, and can be run via the terminal or by double-clicking the exe within the file explorer.

This application will run in the background, therefore to stop it you will need to end the task via the OS task manager.

```bash
# Change mod of bash script
chmod +x ./bash.sh

# Build the executable
# This script will build the application into an executable that can be run on
# Window MacOS or Linux
# This function will automatically create the icon for the application based on
# the png files in the assets directory - update the file keeping the file name
# depending on your OS
./bash.sh build
```

## 🧹 Clean-up

To clean up the project ie remove the build and dist files, run the following code:

```bash
# Change mod of bash script
chmod +x ./bash.sh

# Clean the repository build and distribution files
# This file will run through the build, dist, created icon and spec file(s)
# and remove them from the repo, leaving a fresh state to re-run the build script
./bash.sh clean
```
