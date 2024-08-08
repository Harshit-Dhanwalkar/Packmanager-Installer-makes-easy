# Package Manager Installation Script

This is a Bash script designed to display a list of package managers, their installation status, and allow users to install or remove package managers based on their choices. The script supports various Linux distributions, including Debian-based, RPM-based, Arch-based, SUSE-based, and other package managers.

## Features

- Lists package managers with their installation status.
- Provides an option to install or remove package managers.
- Supports multiple Linux distributions.
- Color-coded output for installed and not installed package managers.

## Usage

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Harshit-Dhanwalkar/Packmanager-Installer-makes-easy.git
   cd Packmanager-Installer-makes-easy
   ```

2. **Make the Script Executable**

   ```bash
   chmod +x check_pkg_manager.sh
   ```

3. **Run the Script**

  ```bash
  ./check_pkg_manager.sh
  ```

4. Follow the Prompts

    The script will display a table of package managers and their status.
    Enter the number corresponding to the package manager you want to install or remove.
    Confirm your choice by typing "yes" or "no".
    Enter your password when prompted for sudo access.

5. Script Details

    Color Coding:
        Green: Installed
        Red: Not Installed
        Blue: Section Titles

    Tables:
        Uses box-drawing characters for table formatting.

    Supported Package Managers:
        Debian-Based: apt, dpkg, snap, flatpak, aptitude, gdebi
        RPM-Based: yum, dnf, rpm, zypper
        Arch-Based: pacman, yay, paru
        SUSE-Based: zypper, swup
        Other: brew, nala, guix, nix, docker, kubectl, helm, composer
        Additional Tools: cargo, pip

# Contributing

  If you'd like to contribute to this project, please fork the repository and submit a pull request. You can also open issues if you find any bugs or have suggestions for improvements.

# Acknowledgments
  
  Thanks to [tput])https://man7.org/linux/man-pages/man1/tput.1.html) for the terminal color codes.
