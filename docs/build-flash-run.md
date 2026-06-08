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

## 2. Flashing the Board (OS-agnostic)

```sh
# In fprime-nucleo_h723zg_freertos_reference (fprime-venv)
STM32_Programmer_CLI -c port=SWD -w build-artifacts/nucleo_H723ZG_FreeRTOS/ReferenceDeployment/bin/ReferenceDeployment.elf.hex -v -rst
```

> [!Note]
> For Linux/WSL, /dev/ttyACM0 might not be the correct port. The correct port can be found with the following command: `ls -l /dev/tty*`. As for MacOS `/dev/cu.usbmodem142101` will likely need to be replaced with the correct port. This can be found by running the following command: `ls -l /dev/cu.usb*`

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

<!-- Links -->
[board-list]: ../additional-resources/board-list.md