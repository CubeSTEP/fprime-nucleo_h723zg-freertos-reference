# Building, Flashing, and Running the Reference Deployment

This guide assumes that the initial setup steps have been completed, and will walk through the steps of building, flashing, and running the reference deployment. This deployment implements an LED blinker component that is able to communicate with the fprime-gds.

## 1. Building the Deployment

1. In order to build the ReferenceDeployment application, or any other F´ application, we first need to generate a build directory. This can be done with the following commands:

```sh
# In fprime-nucleo_h723zg_freertos_reference (fprime-venv)
fprime-util generate
```

2. The next step is to build the ReferenceDeployment application's code.
```sh
# In fprime-nucleo_h723zg_freertos_reference (fprime-venv)
fprime-util build
```

## 2.1 Flashing the Board

```sh
# In fprime-nucleo_h723zg_freertos_reference (fprime-venv)

# General Command 
STM32_Programmer_CLI -c port=SWD -w build-artifacts/nucleo_H723ZG_FreeRTOS/ReferenceDeployment/bin/ReferenceDeployment.elf.hex -v -rst


# Linux/Windows WSL (has only been tested with ubuntu 22.04)
sh ~/.arduino15/packages/STMicroelectronics/tools/STM32Tools/2.4.0/stm32CubeProg.sh -i swd -f build-artifacts/nucleo_H723ZG_FreeRTOS/ReferenceDeployment/bin/ReferenceDeployment.elf.hex -c /dev/ttyAMC0

# MacOS
sh ~/Library/Arduino15/packages/STMicroelectronics/tools/STM32Tools/2.4.0/stm32CubeProg.sh -i swd -f build-artifacts/nucleo_H723ZG_FreeRTOS/ReferenceDeployment/bin/ReferenceDeployment.elf.hex -c /dev/cu.usbmodem142101
```

> [!Note]
> For Linux/WSL, /dev/ttyACM0 might not be the correct port. The correct port can be found with the following command: `ls -l /dev/tty*`. As for MacOS `/dev/cu.usbmodem142101` will likely need to be replaced with the correct port. This can be found by running the following command: `ls -l /dev/cu.usb*`

## 2.2 Possible Issues with Flashing for Ubuntu
This error might print out when running the flash command. This will require some changes to the shell script stm32CubeProg.sh.
```sh
STM32CubeProgrammer not found (STM32_Programmer.sh)
    Please install it or add '<STM32CubeProgrammer path>/bin' to your PATH environment
```
1. First, go to ~/.arduino15/packages/STMicroelectronics/tools/STM32Tools/2.4.0/stm32CubeProg.sh to edit the file. Remove this line of code.
```sh
export PATH="$HOME/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin":"$PATH
```
2. After removing the command, replace it with the line displayed below. Switch out {name} for the appropriate name. The error was that $HOME in the shell script did not provide the right path.
```sh
export PATH="home/{name}/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin":"$PATH
```

## 3.1 Running the Deployment with F' GDS

The following command will spin up the F' GDS as well as run the application binary and the components necessary for the GDS and application to communicate.

```sh
# In fprime-nucleo_h723zg_freertos_reference (fprime-venv)

# Linux/Windows WSL (has only been tested with ubuntu 22.04)
fprime-gds -n --dictionary build-artifacts/nucleo_H723ZG_FreeRTOSS/ReferenceDeployment/dict/ReferenceDeploymentTopologyDictionary.json --communication-selection uart --uart-device /dev/ttyACM0 --uart-baud 115200 --framing-selection fprime

# MacOS
fprime-gds -n --dictionary build-artifacts/nucleo_H723ZG_FreeRTOS/ReferenceDeployment/dict/ReferenceDeploymentTopologyDictionary.json --communication-selection uart --uart-device /dev/cu.usbmodem142101 --uart-baud 115200 
```

> [!Note]
> If the port is incorrect, change /dev/ttyACM0 for Linux/WSL or /dev/cu.usmodem142101 for MacOS to the correct port.

## 3.2 Possible Issues with F' GDS connection

If the top right shows a red x, then a connection has not been made. It is possible that the laptop port used to connect to F' GDS do not have the right permissions. A command can be used to elevate the permissions for the port.

```sh
# Linux/Windows WSL (Adapt According to Port #)
sudo chmod 777 /dev/ttyACM0

# Mac (Adapt Acording to Port #)
sudo chomd 777 /dev/cu.usbmodem12345
```

## Any Issues?
Refer to the [additional resources][additional-resources] section in the main README file for potential fixes.

<!-- Links -->
[board-list]: ../additional-resources/board-list.md
[additional-resources]: ../../README.md#additional-resources