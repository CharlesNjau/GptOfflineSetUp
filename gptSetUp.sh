#!/bin/bash

# Check if Homebrew is present and install if necessary
if ! command -v brew &> /dev/null
then
    echo "Homebrew could not be found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew installed successfully"
fi

# Check if Python is present and install if necessary
if ! command -v python3 &> /dev/null
then
    echo "Python could not be found. Installing Python..."
    brew install python
    echo 'export PATH="/usr/local/opt/python/libexec/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    echo "Python installed successfully"
fi

# Check if pip is present and install if necessary
if ! command -v pip3 &> /dev/null
then
    echo "pip could not be found. Installing pip..."
    sudo easy_install pip
    echo 'export PATH="/usr/local/opt/python/libexec/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    echo "pip installed successfully"
fi

# Check if git is present and install if necessary
if ! command -v git &> /dev/null
then
    echo "git could not be found. Installing git..."
    brew install git
    echo "git installed successfully"
fi

# Install ChatGPT offline
wget https://github.com/nomic-ai/gpt4all/raw/main/gpt4all-lora-quantized-OSX-m1 -O gpt4all-lora-quantized.bin
git clone --recurse-submodules https://github.com/nomic-ai/gpt4all.git
cd gpt4all
pip3 install -r requirements.txt
cd transformers
pip3 install -e .
cd ../peft
pip3 install -e .

if [ -f chat/gpt4all-lora-quantized.bin ]; then
    echo "Chat model already downloaded. Skipping download."
else
    echo "Downloading chat model..."
    curl -L https://github.com/nomic-ai/gpt4all/releases/download/v1.0.0/gpt4all-lora-quantized.bin -o chat/gpt4all-lora-quantized.bin
    echo "Chat model downloaded successfully"
fi

echo 'export PATH="~/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

echo "ChatGPT offline installed successfully"
