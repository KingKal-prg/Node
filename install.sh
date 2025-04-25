#!/bin/bash

# Print bold message with a border
print_bold_with_outline() {
    local msg="$1"
    local length=${#msg}
    local border=""

    for i in $(seq 1 $((length + 4))); do
        border="${border}#"
    done

    echo -e "\e[1m\e[44m$border\e[0m"
    echo -e "\e[1m\e[44m# $msg #\e[0m"
    echo -e "\e[1m\e[44m$border\e[0m"
}

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
RESET="\e[0m"

print_bold_with_outline "Welcome to Kelvin's Arcade, member!"

if ! command -v git > /dev/null; then
    echo -e "${RED}[Error] Git is not installed. Please install Git and try again.${RESET}"
    exit 1
fi

echo -e "${BLUE}[1/4] Fetching the Kelvin's Arcade files...${RESET}"
if git clone https://github.com/DogeNetwork/v4 > /dev/null 2>&1; then
    echo -e "${GREEN}[Success] Files downloaded successfully.${RESET}"
else
    echo -e "${RED}[Error] Couldn't download the files. Check your internet connection or make sure the folder doesn't already exist.${RESET}"
    exit 1
fi

cd v4 || { echo -e "${RED}[Error] Unable to enter the Kelvin's Arcade folder.${RESET}"; exit 1; }

echo -e "${BLUE}[2/4] Installing required packages...${RESET}"
if npm install --progress=false > /dev/null 2>&1; then
    echo -e "${GREEN}[Success] All dependencies installed.${RESET}"
else
    echo -e "${RED}[Error] Something went wrong while installing dependencies.${RESET}"
    exit 1
fi

echo -e "${BLUE}[3/4] Launching Kelvin's Arcade...${RESET}"
npm start

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[Success] Kelvin's Arcade is now running.${RESET}"
    echo -e "${YELLOW}[Info] Access the Arcade at http://localhost in your browser.${RESET}"
else
    echo -e "${RED}[Error] Failed to start Kelvin's Arcade. Please check the logs for more info.${RESET}"
    exit 1
fi

echo -e "${BLUE}[4/4] Setup Complete. Enjoy your experience!${RESET}"
