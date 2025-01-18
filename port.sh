#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
YELLOW='\033[0;33m'

usage() {
    echo -e "${BLUE}========================================"
    echo -e "       ${RED}PORT Scanner By Maloy Roy Orko${NC}       "
    echo -e "${CYAN}========================================"
    
    if ! command -v figlet &> /dev/null; then
        echo -e "${GREEN}Installing figlet...${NC}"
        pkg install figlet -y
    fi
    
    echo -e "${YELLOW}"
    figlet -w 200 -f slant "PORT"
figlet -w 200 -f slant " SCANNER"
    echo -e "${NC}"
    sleep 1
    echo -e "${GREEN}Usage: $0 <target_ip> [<start_port> <end_port>}${NC}"
    echo -e "${BLUE}Example: $0 192.168.0.1 1 800${NC}"
    echo -e "${YELLOW}Or to scan all ports: $0 192.168.0.1${NC}"
    exit 1
}

if [ "$#" -lt 1 ]; then
    usage
fi

TARGET_IP=$1
START_PORT=${2:-1}
END_PORT=${3:-65535}

if ! command -v nmap &> /dev/null; then
    echo -e "${RED}nmap could not be found. Installing it now...${NC}"
    
    if [ -x "$(command -v pkg)" ]; then
        pkg install -y nmap
    else
        echo -e "${RED}Package manager not found. Please install nmap manually.${NC}"
        exit 1
    fi
fi

echo -e "${BLUE}Scanning ports ${GREEN}$START_PORT${BLUE} to ${GREEN}$END_PORT ${BLUE}on ${GREEN}$TARGET_IP...${NC}"
nmap -p $START_PORT-$END_PORT $TARGET_IP

echo -e "${GREEN}Port scan completed.${NC}"
