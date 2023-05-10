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

*config-db.sh* - Is run inside the base image at build time as the postgres user to configure PostgreSQL, because `sudo` and `runuser` break in chroots and I didn't want to set up systemd-nspawn for this yet.

*run.sh* - Is run on start of determined-wsl to check PostgreSQL, Docker, Determined services are running, then launches the Determined AI web interface in the default Windows browser. **Note**: The default credentials for the Determined web UI is admin and no password.

*install.ps1* - Checks for WSL updates, imports determined-wsl into WSL 2, and then runs determined-wsl. **Note**: If WSL is updated then the script will exit and need to be re-run.

### Possible To Do's

* Improve the run.sh script to do more sanity checks and give a nice HUD experence
* Build a nice GUI around this, e.g. Docker Desktop
* Wrap the image in an Win32 installer with Determined icon and WIndows Terminal theme
* Scoop and Winget packages
* Automate fresh image builds using GitHub Actions
* Push the build to the Microsoft Store
