#!/bin/bash

# Function to set up swap
setup_swap() {
    read -p "Enter swap size in MB: " swap_size
    if ! [[ "$swap_size" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter a valid number."
        exit 1
    fi

    # Create swap file
    sudo fallocate -l ${swap_size}M /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    # Add swap entry to /etc/fstab for persistence
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    echo "Swap of ${swap_size}MB set up successfully."
}

# Function to remove all swap
remove_swap() {
    # Turn off all swap
    sudo swapoff -a

    # Remove swap entries from /etc/fstab
    sudo sed -i '/swap/d' /etc/fstab

    # Remove swap files
    sudo rm -f /swapfile

    echo "All swap removed successfully."
}

# Main script
echo "Choose an option:"
echo "1. Set up swap"
echo "2. Remove all swap"
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        setup_swap
        ;;
    2)
        remove_swap
        ;;
    *)
        echo "Invalid choice. Please enter 1 or 2."
        exit 1
        ;;
esac
