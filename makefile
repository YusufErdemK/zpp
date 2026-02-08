# Z++ Programming Language Makefile
# Author: YusufErdemK
# Description: Build and run Z++ programs

.PHONY: help install build clean uninstall

# Default target - show help
help:
	@echo "Z++ Makefile Commands:"
	@echo "  make install           - Install ZPC compiler"
	@echo "  make build FILE=<file> - Compile a Z++ file"
	@echo "  make clean             - Clean generated files"
	@echo "  make uninstall         - Uninstall ZPC compiler"
	@echo ""
	@echo "Examples:"
	@echo "  make install"
	@echo "  make build FILE=hello.zpp"

# Install ZPC compiler
install:
	@echo "Installing ZPC compiler..."
	@chmod +x zpc/install.sh
	@cd zpc && sudo ./install.sh
	@echo "Installation complete!"

# Build a Z++ file
build:
ifndef FILE
	@echo "Error: FILE parameter is required"
	@echo "Usage: make build FILE=your_file.zpp"
	@exit 1
endif
	@echo "Compiling $(FILE)..."
	@zpc $(FILE)
	@echo "Compilation complete!"

# Clean generated files (HTML outputs)
clean:
	@echo "Cleaning generated files..."
	@find . -maxdepth 1 -name "*.html" -type f -delete
	@echo "Clean complete!"

# Uninstall ZPC
uninstall:
	@echo "Uninstalling ZPC..."
	@if [ -f zpc/uninstall.sh ]; then \
		chmod +x zpc/uninstall.sh; \
		cd zpc && sudo ./uninstall.sh; \
	else \
		sudo rm -f /usr/local/bin/zpc; \
		echo "ZPC removed from /usr/local/bin/"; \
	fi
	@echo "Uninstall complete!"