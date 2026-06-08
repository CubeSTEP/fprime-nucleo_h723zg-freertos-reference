# Initial Project Setup

This guide will walk through the steps of setting up the reference deployment.

<!-- TODO: UPDATE REPO NAME -->
## 1. Clone the GitHub repository
Clone the GitHub repository onto your local machine.
```sh
git clone https://github.com/CubeSTEP/fprime-nucleo_h723zg-freertos-reference.git
```
> [!NOTE]
> If you would like to use fprime-bootstrap instead of git to clone this project, run this command and skip to step 5.
> ```sh
> fprime-bootstrap clone https://github.com/CubeSTEP/fprime-nucleo_h723zg-freertos-reference.git
> ```


## 2. Fetch git submodules
Install the required libraries for this deployment
```sh
# In fprime-nucleo_h723zg_freertos_reference
git submodule update --recursive --init
```

## 3. Create a virtual environment

[!NOTE] MacOs users will need to install python3 and pip3 if they are not already installed. This can be done using Homebrew with the following command:

```sh
# Setup Homebrew (if not installed) https://brew.sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install python3 and pip3
brew install python3
```

## General Instructions

Create a virtual environment in the main project directory

```sh
# In fprime-nucleo_h723zg_freertos_reference
python3 -m venv fprime-venv
```

## 4. Activate the virtual environment

```sh
# In fprime-nucleo_h723zg_freertos_reference
# Linux, MacOS, & Windows WSL
source fprime-venv/bin/activate
```

## 5. Install python requirements
With the virtual environment activated, install the requirements
```sh
# In fprime-nucleo_h723zg_freertos_reference (fprime-venv)
pip install -r lib/fprime/requirements.txt
```

# # Install arduino-cli

## Linux/Windows WSL
```sh
curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=$VIRTUAL_ENV/bin sh
```

## MacOS

```sh
brew install arduino-cli

-  Add arduino-cli to path
```sh
echo 'fpath=(/opt/homebrew/share/zsh/site-functions $fpath)' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

## Generic
```sh
pip install git+https://github.com/CubeSTEP/arduino-cli-cmake-wrapper.git@main

arduino-cli config init

arduino-cli config add board_manager.additional_urls https://github.com/stm32duino/BoardManagerFiles/raw/main/package_stmicroelectronics_index.json

arduino-cli core update-index
    
arduino-cli core install STMicroelectronics:stm32

arduino-cli lib install "STM32duino FreeRTOS"

arduino-cli lib install "Time"
```

# Install the STM32 CubeProgrammer
- Visit the following webpage [STM32 CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html) and download the appropriate version for your operating system.

- STM32 Programmer CLI will be installed at the following locations depending on the operating system that you are using:

```sh
macOS x86_64: STM32CubeProgrammer.app/Contents/MacOs/bin/STM32_Programmer_CLI
macOS aarch64: STM32CubeProgrammer.app/Contents/Resources/bin/STM32_Programmer_CLI
Windows: ..\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe
Linux: ../STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI
```

- Add the STM32 Programmer CLI to your system path. For example, on Linux you can add the following line to your .bashrc or .zshrc file:
```bash
# General syntax: export PATH="/path/to/STM32CubeProgrammer/bin:\$PATH"
export PATH="\(HOME/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:\)PATH"
```
[!NOTE] Make sure to have the path for the bin of the programmer in the location where is installed on your machine. 

# Next Steps: [Building, Flashing, and Running the Deployment][build-flash-run]

<!-- Links -->
[build-flash-run]: ./build-flash-run.md