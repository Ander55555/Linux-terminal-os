#!/bin/bash

# --- CONFIGURATION ---
# Define a temporary file to store menu selections
TEMP_FILE=$(mktemp -t input.XXXXXX)

# Trap CTRL+C and ensure cleanup on exit
trap cleanup SIGINT SIGTERM EXIT

# --- FUNCTIONS ---

cleanup() {
    rm -f "$TEMP_FILE"
    clear
}

# 1. System Info App (using dialog msgbox)
app_sysinfo() {
    INFO_TEXT="
    Kernel: $(uname -r)
    Uptime: $(uptime -p)
    User:   $(whoami)
    Shell:  $SHELL
    "
    dialog --title "System Info" \
           --msgbox "$INFO_TEXT" 10 50
}

# 2. Calculator (using dialog inputbox)
app_calc() {
    while true; do
        # Get input
        dialog --title "Calculator" \
               --inputbox "Enter equation (e.g., 5+5) or leave empty to exit:" 8 40 2> "$TEMP_FILE"
        
        # Check if user cancelled or entered nothing
        if [ $? -ne 0 ]; then break; fi
        EQ=$(cat "$TEMP_FILE")
        if [ -z "$EQ" ]; then break; fi

        # Calculate
        RESULT=$(echo "$EQ" | bc -l 2>/dev/null)
        
        # Show result
        dialog --title "Result" --msgbox "Result: $RESULT" 6 30
    done
}

# 3. File Browser (using dialog fselect)
app_files() {
    # Opens a clickable file selection window starting at current directory
    FILE=$(dialog --stdout --title "File Browser" --fselect ./ 14 48)
    
    if [ ! -z "$FILE" ]; then
        dialog --msgbox "You selected:\n$FILE" 6 50
    fi
}

# 4. Shutdown Confirmation
shutdown_os() {
    dialog --title "Shutdown" \
           --yesno "Are you sure you want to shut down RetroBash?" 7 40
    
    # $? captures the exit code (0 = Yes, 1 = No)
    if [ $? -eq 0 ]; then
        clear
        echo "Shutting down..."
        sleep 1
        exit 0
    fi
}

# --- MAIN LOOP ---

while true; do
    # Display the Main Menu
    # The format is: dialog --menu "Title" Height Width MenuHeight "Tag" "Item" ...
    dialog --clear \
           --backtitle "RetroBash OS v2.0 (Mouse Enabled)" \
           --title "Main Menu" \
           --menu "Use UP/DOWN keys or CLICK with your mouse:" \
           15 50 6 \
           "1" "System Information" \
           "2" "Calculator" \
           "3" "File Browser" \
           "4" "Text Editor (Nano)" \
           "0" "Shutdown" 2> "$TEMP_FILE"

    # Check if user pressed Cancel (exit status non-zero)
    if [ $? -ne 0 ]; then
        shutdown_os
        # If they said 'No' to shutdown, loop continues
        continue
    fi

    # Read the choice from the temp file
    choice=$(cat "$TEMP_FILE")

    case $choice in
        1) app_sysinfo ;;
        2) app_calc ;;
        3) app_files ;;
        4) nano ;; 
        0) shutdown_os ;;
    esac
done
