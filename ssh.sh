#!/bin/bash

# 1. Define what happens when you press Ctrl+C
cleanup() {
    echo -e "\nStopping SSH service and re-enabling sleep..."
    sudo systemctl stop sshd
    echo "Done. You can now close the terminal."
    exit 0
}

# 2. "Trap" the Ctrl+C signal and route it to the cleanup function
trap cleanup SIGINT SIGTERM

# 3. Start SSH
echo "Starting SSH service..."
sudo systemctl start sshd

# 4. Block sleep. The script will pause here until you press Ctrl+C
echo "Laptop is kept awake for remote dev. Press Ctrl+C to stop."
sudo systemd-inhibit --what=sleep:idle --who="VSCode" --why="Remote dev session" sleep infinity
