## A WSL distro image with Determined AI pre-installed and configured.

This is an initial, very rough, proof of concept. It is not officially supported.

### Files

build.sh - Builds a minimal Ubuntu 22.04 base image with the dependencies needed for Determined AI. Requires Ubuntu 22.04 or later.

config.sh - Is run inside the base image at build time to install Docker and Determined.

config-db.sh - Is run inside the base image at build time as the postgres user to configure PostgreSQL, because `sudo` and `runuser` break in chroots and I didn't want to set up systemd-nspawn for this yet.

run.sh - Is run on start of determined-wsl to check PostgreSQL, Docker, Determined services are running, then launches the Determined AI web interface in the default Windows browser. **Note**: The default password for the Determined web UI is admin and no password.

install.ps1 - Checks for WSL updates, imports determined-wsl into WSL2, and then runs determined-wsl. **Note**: If WSL is updated then the script will exit and need to be re-run.

### Known Issues

**CUDA devices do not show up when determined-agent is started by systemd.** This could be an issue with determined-agent, NVIDIA Container Runtime, or systemd on WSL, more investigation is required.

If you have a CUDA enabled NVIDIA GPU and CUDA slots are not appearing in Determined, stop the determined-agent service as managed by systemd:

`systemctl stop determined-agent`

And run determined-agent manually:

`determined-agent run`

If you recieve the message "agent is past reconnect period, it must restart", simply re-run `determined-agent run`.

You may want to disable the determined-agent systemd service:

`systemctl disable determined-agent`

And launch determined-agent manually on each launch:

`echo 'determined-agent run' >> /etc/profile`

### Possible To Dos

Improve the run.sh script to do more sanity checks and give a nice HUD experence
Build a nice GUI around this, e.g. Docker Desktop
Wrap the image in an Win32 installer with Determined icon and WIndows Terminal theme
Automate fresh image builds using GitHub Actions
An Arm build