#!/bin/bash
clear
echo "Determined AI WSL"
echo "Waiting for systemd to start Docker, PostgreSQL, and Determined"
sleep 5
systemctl is-active --quiet docker
if [[ $? -ne 0 ]] ; then
    echo "Error: Docker is not running"
    exit 1
else
    echo "docker is running"
fi
systemctl is-active --quiet postgresql 
if [[ $? -ne 0 ]] ; then
    echo "Error: postgresql is not running"
    exit 1
else
    echo "postgresql is running"
fi
systemctl is-active --quiet determined-master 
if [[ $? -ne 0 ]] ; then
    echo "Error: determined-master is not running"
    exit 1
else
    echo "determined-master is running"
fi
systemctl is-active --quiet determined-agent 
if [[ $? -ne 0 ]] ; then
    echo "Error: determined-agent is not running, start it manually with: determined-agent run"
else
    echo "determined-agent is running"
fi

echo "Launching the Determined web UI..."
powershell.exe /C start http://localhost:8080

echo "Determined AI is running. You may now minimize this window."
echo
echo
echo
