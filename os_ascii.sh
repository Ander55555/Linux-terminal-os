#!/bin/bash

# --- CONFIGURATION & COLORS ---
# ANSI Color Codes for the "OS" look
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Trap CTRL+C so the user can't accidentally exit the "OS"
trap '' SIGINT

# --- FUNCTIONS ---

# 1. The Header / ASCII Art
draw_header() {
    clear
    echo -e "${CYAN}"
    echo "  ____  _____ _____ ____  ____   "
    echo " |  _ \| ____|_   _|  _ \|  _ \  "
    echo " | |_) |  _|   | | | |_) | |_) | "
    echo " |  _ <| |___  | | |  _ <|  __/  "
    echo " |_| \_\_____| |_| |_| \_\_|     "
    echo -e "${NC}"
    echo -e "${BLUE}  ===============================${NC}"
    echo -e "${WHITE}  Welcome to RetroBash OS v1.0   ${NC}"
    echo -e "${BLUE}  User: $(whoami) | Host: $(hostname)${NC}"
    echo -e "${BLUE}  ===============================${NC}"
    echo ""
}

# 2. The System Info App
app_sysinfo() {
    draw_header
    echo -e "${YELLOW}--- SYSTEM INFORMATION ---${NC}"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "Date:   $(date)"
    echo "Shell:  $SHELL"
    echo ""
    read -p "Press Enter to return to main menu..."
}

# 3. The Calculator App
app_calc() {
    while true; do
        draw_header
        echo -e "${YELLOW}--- CALCULATOR ---${NC}"
        echo "Format: a + b (e.g., 5 + 5)"
        echo "Type 'x' to exit calculator."
        echo ""
        read -p "Calc > " eq
        
        if [[ "$eq" == "x" ]]; then
            break
        fi
        
        # Using 'bc' for calculation, defaulting to 0 if error
        res=$(echo "$eq" | bc -l 2>/dev/null)
        echo -e "${GREEN}Result: $res${NC}"
        sleep 2
    done
}

# 4. File Manager (Simple List)
app_files() {
    draw_header
    echo -e "${YELLOW}--- FILE BROWSER ---${NC}"
    ls -lh --group-directories-first
    echo ""
    read -p "Press Enter to return to main menu..."
}

# 5. Shutdown Animation
shutdown_os() {
    clear
    echo -e "${RED}Shutting down system...${NC}"
    sleep 1
    echo -e "${RED}Saving session...${NC}"
    sleep 1
    echo -e "${WHITE}Goodbye!${NC}"
    exit 0
}

# --- MAIN LOOP ---

while true; do
    draw_header
    
    # Display Menu Options
    echo -e "  [1] ${GREEN}System Info${NC}"
    echo -e "  [2] ${GREEN}Calculator${NC}"
    echo -e "  [3] ${GREEN}File Browser${NC}"
    echo -e "  [4] ${GREEN}Text Editor (Nano)${NC}"
    echo -e "  [0] ${RED}Shutdown${NC}"
    echo ""
    read -p "  Select an option > " choice

    # Handle Input
    case $choice in
        1) app_sysinfo ;;
        2) app_calc ;;
        3) app_files ;;
        4) nano ;; # Launches real nano, returns here on exit
        0) shutdown_os ;;
        *) 
           echo -e "${RED}  Invalid option!${NC}" 
           sleep 1 
           ;;
    esac
done
