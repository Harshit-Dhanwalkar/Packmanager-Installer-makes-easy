#!/bin/bash

# Define colors using tput
green=$(tput setaf 2)
red=$(tput setaf 1)
blue=$(tput setaf 4)
reset=$(tput sgr0)

# Function to print table rows
print_row() {
    local num="$1"
    local pm="$2"
    local status="$3"

    if [[ "$status" == "${green}Installed${reset}" ]]; then
        # Print with extra spacing if installed
        printf "│ %2d  │   %-24s │       %-27s│\n" "$num" "$pm" "$status"
    else
        # Print with standard spacing if not installed
        printf "│ %2d  │   %-24s │       %-27s│\n" "$num" "$pm" "$status"
    fi
}

# Function to print a table header
print_header() {
    printf "┌─────┬────────────────────────────┬───────────────────────┐\n"
    printf "│ No  │     %-20s   │        %s         │\n" "Package Manager" "Status"
    printf "├─────┼────────────────────────────┼───────────────────────┤\n"
}

# Function to print a table footer
print_footer() {
    printf "└─────┴────────────────────────────┴───────────────────────┘\n"
}

# Function to print a section with header and rows
print_section() {
    local section_name="$1"
    shift
    printf "\n${blue}%s:${reset}\n" "$section_name"
    print_header
    local idx=1
    for pm in "$@"; do
        if command -v $pm &>/dev/null; then
            print_row "$idx" "$pm" "${green}Installed${reset}"
        else
            print_row "$idx" "$pm" "${red}Not Installed${reset}"
            options+=("$pm")
            numbers+=("$idx")
        fi
        idx=$((idx + 1))
    done
    print_footer
}

# Function to ask user about installing or removing a package manager
ask_user_action() {
    echo -e "\n${blue}Install or remove package manager:${reset}"

    read -p "Enter the number of the package manager: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [[ " ${numbers[*]} " == *" $choice "* ]]; then
        selected_pm=${options[$((choice - 1))]}
        echo -e "\n${blue}You selected: $selected_pm${reset}"
        read -p "Do you want to install or remove $selected_pm? (yes/no): " action
        if [[ "$action" == "yes" ]]; then
            echo "Processing..."
            echo -e "Password required for sudo: \c"
            sudo -v  # Prompt for password once
            if command -v $selected_pm &>/dev/null; then
                echo "Removing $selected_pm..."
                sudo apt-get remove -y "$selected_pm"
            else
                echo "Installing $selected_pm..."
                sudo apt-get install -y "$selected_pm"
            fi
        else
            echo "Skipping $selected_pm."
        fi
    else
        echo "Invalid choice."
    fi
}

# Function to print all sections and ask user for actions
print_and_ask() {
    local section_name="$1"
    shift
    print_section "$section_name" "$@"
    if [ ${#options[@]} -gt 0 ]; then
        ask_user_action
    else
        echo "No package managers to install or remove."
    fi
}

# Initialize options and numbers arrays
options=()
numbers=()

# Execute sections and prompts
print_and_ask "Debian-Based" apt dpkg snap flatpak aptitude gdebi
print_and_ask "RPM-Based" yum dnf rpm zypper
print_and_ask "Arch-Based" pacman yay paru
print_and_ask "SUSE-Based" zypper swup
print_and_ask "Other" brew nala guix nix docker kubectl helm composer
print_and_ask "Additional Tools" cargo pip

# in one line
# for pm in apt dpkg snap nala brew flatpak pacman zypper yum dnf; do command -v $pm &>/dev/null && echo "$pm is installed"; done
