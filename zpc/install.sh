#!/bin/bash

# Z++ Compiler (zpc) Installation Script
# Zexis OS Development Tool

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${PURPLE}"
echo "╔══════════════════════════════════════╗"
echo "║      ZPC - Z++ Compiler v1.0.0       ║"
echo "║       Installation Script            ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ZPC_FILE="$SCRIPT_DIR/zpc"
INSTALL_DIR="/usr/local/bin"
INSTALL_PATH="$INSTALL_DIR/zpc"

# Root check
if [ "$EUID" -ne 0 ]; then 
    echo -e "${YELLOW}⚠️  This script requires root privileges.${NC}"
    echo -e "${CYAN}📝 Rerunning with sudo...${NC}\n"
    sudo "$0" "$@"
    exit $?
fi

# Check if zpc file exists
if [ ! -f "$ZPC_FILE" ]; then
    echo -e "${RED}❌ Error: zpc file not found!${NC}"
    echo -e "${YELLOW}   Expected location: $ZPC_FILE${NC}"
    echo -e "${CYAN}💡 Place the zpc file in the same folder as install.sh${NC}"
    exit 1
fi

echo -e "${CYAN}🔍 Found zpc file: $ZPC_FILE${NC}"

# Python3 check
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ Error: python3 not found!${NC}"
    echo -e "${YELLOW}   Python 3 is not installed.${NC}"
    echo -e "${CYAN}💡 To install: sudo apt install python3${NC}"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo -e "${GREEN}✓ Python installed: $PYTHON_VERSION${NC}"

# Check if /usr/local/bin exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}⚠️  Directory $INSTALL_DIR not found, creating...${NC}"
    mkdir -p "$INSTALL_DIR"
fi

# Check for existing installation
if [ -f "$INSTALL_PATH" ]; then
    echo -e "${YELLOW}⚠️  Found existing zpc installation.${NC}"
    echo -e "${CYAN}🔄 Updating...${NC}"
    rm -f "$INSTALL_PATH"
fi

# Copy zpc file
echo -e "${CYAN}📦 Installing...${NC}"
cp "$ZPC_FILE" "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Installation failed! Could not copy file.${NC}"
    exit 1
fi

# Set executable permission
chmod +x "$INSTALL_PATH"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Could not set executable permission!${NC}"
    exit 1
fi

# Verify installation
if [ -f "$INSTALL_PATH" ] && [ -x "$INSTALL_PATH" ]; then
    echo -e "${GREEN}✅ Installation successful!${NC}\n"
    
    # Information
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║       Installation Complete!           ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}\n"
    
    echo -e "${CYAN}📍 Installation Location:${NC} $INSTALL_PATH"
    echo -e "${CYAN}🐍 Python Version:${NC} $PYTHON_VERSION"
    echo -e "${CYAN}📁 Source File:${NC} $ZPC_FILE\n"
    
    echo -e "${GREEN}Usage:${NC}"
    echo -e "  ${YELLOW}zpc <file.zpp>${NC}          - Compile file"
    echo -e "  ${YELLOW}zpc <file.zpp> -v${NC}       - Compile with verbose output"
    echo -e "  ${YELLOW}zpc --help${NC}               - Show help message"
    echo -e "  ${YELLOW}zpc --version${NC}            - Show version info\n"
    
    echo -e "${GREEN}Example:${NC}"
    echo -e "  ${CYAN}zpc app.zpp${NC}\n"
    
    # Test
    echo -e "${CYAN}🧪 Testing...${NC}"
    if zpc --version &> /dev/null; then
        echo -e "${GREEN}✓ zpc command is working!${NC}\n"
    else
        echo -e "${YELLOW}⚠️  Could not test zpc command.${NC}"
        echo -e "${CYAN}💡 Try restarting your terminal.${NC}\n"
    fi
    
    echo -e "${PURPLE}╔════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║   Ready to code with Z++! 🚀           ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}\n"
    
else
    echo -e "${RED}❌ Installation could not be verified!${NC}"
    exit 1
fi

# Uninstall instructions
echo -e "${CYAN}ℹ️  To uninstall:${NC}"
echo -e "   ${YELLOW}sudo rm /usr/local/bin/zpc${NC}\n"

exit 0