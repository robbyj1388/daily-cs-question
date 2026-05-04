# Makefile
FILE_NAME := __main__.py
SCRIPT_PATH := $(CURDIR)/src/$(FILE_NAME)
BASHRC := $(HOME)/.bashrc
INSTALL_DIR := $(HOME)/.local/bin
VENV_NAME := .venv
VENV_DIR := $(HOME)/.local/state/daily_question
VENV_PATH := $(VENV_DIR)/$(VENV_NAME)/bin/python

.PHONY: install

install:
	@echo "Installing script to $(INSTALL_DIR)..."
	@mkdir -p "$(INSTALL_DIR)"
	cp "$(SCRIPT_PATH)" "$(INSTALL_DIR)/$(FILE_NAME)"
	@mkdir -p "$(VENV_DIR)"
	@if [ ! -d "$(VENV_DIR)/$(VENV_NAME)" ]; then \
		python3 -m venv "$(VENV_DIR)/$(VENV_NAME)"; \
	fi; \
	"$(VENV_DIR)/$(VENV_NAME)/bin/pip" install -r requirements.txt

	@echo "Updating $(BASHRC)..." 
	@if ! grep -Fq "# Daily cs question" "$(BASHRC)"; then \
		echo "" >> "$(BASHRC)"; \
		echo "# Daily cs question" >> "$(BASHRC)"; \
		echo "$(VENV_PATH) $(INSTALL_DIR)/$(FILE_NAME)" >> "$(BASHRC)"; \
		echo "# Daily cs question end" >> "$(BASHRC)"; \
	fi

	@echo "Done!"
