#!/bin/bash
# Google Workspace Authentication Setup
# For MARVIN template users
# Created by Sterling Chin

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  Google Workspace Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check Python
echo -e "${BLUE}Checking prerequisites...${NC}"

if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    echo -e "${GREEN}  Python $PYTHON_VERSION${NC}"
else
    echo -e "${RED}  Python 3 not found${NC}"
    echo "  Install with: brew install python@3.11"
    exit 1
fi

# Check/install required packages
echo ""
echo -e "${BLUE}Checking Python packages...${NC}"

# Create venv if it doesn't exist
if [ ! -d "venv" ]; then
    echo -e "${YELLOW}  Creating virtual environment...${NC}"
    python3 -m venv venv
fi

# Activate venv
source venv/bin/activate

# Install required packages
pip install -q google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client

echo -e "${GREEN}  Required packages installed${NC}"

# Run the setup
echo ""
python3 scripts/google_auth.py --setup

# Deactivate venv
deactivate

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "Your Google credentials are saved in this directory."
echo "Claude Code can now access your Google Workspace."
echo ""
