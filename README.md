# Deprecation Notice

This project is deprecated. [Follow the official Determined docs](https://docs.determined.ai/latest/setup-cluster/on-prem/options/wsl.html) to run WSL on your favorite Linux distro on WSL.

## A WSL distro image with Determined AI pre-installed and configured.

![Screenshot 2023-05-04 163007 - Copy](https://user-images.githubusercontent.com/33820650/236331092-559dcd0b-16f3-4e0c-b602-deba0f07e0f2.png)

[Determined](https://github.com/determined-ai/determined) is an open-source deep learning training platform that makes building models fast and easy.

This is an initial, rough, proof of concept of Determined pre-installed and configured running on a WSL image. 

It is **not officially supported**. However, it does work, and supports NVIDIA CUDA devices.

### To Install

Install WSL 2:

`wsl.exe --install`

Download the latest [release](https://github.com/sirredbeard/determined-wsl/releases) of determined-wsl.

Import the WSL image:

`wsl.exe --import determined-wsl C:\determined-wsl install.tar.gz --version=2`

If you prefer a GUI to manage your WSL distributions, I recommend [Raft WSL](https://www.whitewaterfoundry.com/raft-wsl).

### To Run

From PowerShell:

`wsl.exe -d determined-wsl`

From Windows Terminal:

determined-wsl will automatically appear in the drop-down box of [Windows Terminal](https://www.microsoft.com/store/productId/9N0DX20HK701).

### Files

*build.sh* - Builds a minimal Ubuntu 22.04 base image with the dependencies needed for Determined AI. Requires Ubuntu 22.04 or later.

*config.sh* - Is run inside the base image at build time to install Docker and Determined.

*run.sh* - Is run on start of determined-wsl.

*install.ps1* - Checks for WSL updates, imports determined-wsl into WSL 2, and then runs determined-wsl.