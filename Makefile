#!/usr/bin/env make
#
# makefile for project commands
#

app_root := ${PWD}


setup:
	@zsh setup_dotfiles.sh

backup:
	@zsh backup_dotfiles.sh
