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

- STM32 Programmer CLI will be installed at a location similar to one of the following paths depending on your operating system:

```sh
macOS: /Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/Resources/bin/STM32_Programmer_CLI
Windows: C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe
Linux: $HOME/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI
```

- Add the directory containing `STM32_Programmer_CLI` to your system path. Do not add the executable file itself.

General shell syntax:

```sh
export PATH="/path/to/STM32CubeProgrammer/bin:$PATH"
```

macOS example:

```sh
export PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/Resources/bin:$PATH"
```

Apple Silicon macOS zsh example:

```sh
export PATH="/Applications/STMicroelectronics/STM32Cube/STM32CubeProgrammer/STM32CubeProgrammer.app/Contents/Resources/bin:$PATH"

if [[ "$(uname -m)" == "arm64" ]]; then
  alias STM32_Programmer_CLI='arch -x86_64 STM32_Programmer_CLI'
fi
```

Linux example:

```bash
export PATH="$HOME/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin:$PATH"
```

Windows PowerShell example:

```powershell
$env:Path += ";C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin"
```

To make the change persistent on Linux or macOS, add the matching `export PATH=...` line to your shell startup file:

```sh
# zsh
echo 'export PATH="/path/to/STM32CubeProgrammer/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# bash
echo 'export PATH="/path/to/STM32CubeProgrammer/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Verify the CLI is available:

```sh
STM32_Programmer_CLI --version
```

On Apple Silicon macOS, if the command prints `Incompatible processor` with a `neon` message, use the zsh alias above or run the CLI through Rosetta manually:

```sh
arch -x86_64 STM32_Programmer_CLI --version
```

> [!NOTE]
> Shell aliases work for commands typed in an interactive terminal. Scripts that call `STM32_Programmer_CLI` directly may still need to run through Rosetta or use a wrapper script.

> [!NOTE]
> Make sure the path points to the `bin` directory where STM32 CubeProgrammer is installed on your machine.

# Next Steps: [Building, Flashing, and Running the Deployment][build-flash-run]

<!-- Links -->
[build-flash-run]: ./build-flash-run.md
