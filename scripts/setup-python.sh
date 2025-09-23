#!/bin/bash

# Install pyenv if not already installed
if ! command -v pyenv &> /dev/null; then
    echo "Installing pyenv..."
    brew install pyenv
fi

# Add pyenv to shell
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# Reload shell configuration
source ~/.zshrc

# Install Python versions
pyenv install 3.11.0
pyenv global 3.11.0

# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Add Poetry to path
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# Reload shell configuration again
source ~/.zshrc

# Create a default virtual environment
python -m venv ~/.venv/default
echo 'source ~/.venv/default/bin/activate' >> ~/.zshrc

# Install common development tools
pip install --upgrade pip
pip install black flake8 mypy isort pytest

echo "Python setup complete! Please restart your terminal for all changes to take effect." 