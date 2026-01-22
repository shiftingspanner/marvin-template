#!/bin/bash
# Complete Setup Script for Non-Developers
# Installs everything needed from scratch on a fresh Mac
# Created by Sterling Chin

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Client ID (shared across team)
GOOGLE_CLIENT_ID="1040834205770-pm3p706jo090otse75td7ob9bdfrbomq.apps.googleusercontent.com"

clear
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║   ${BLUE}Claude Code Setup for Postman Team${CYAN}                      ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║   This will install and configure:                         ║${NC}"
echo -e "${CYAN}║   ${GREEN}✓${CYAN} Claude Code (AI assistant)                             ║${NC}"
echo -e "${CYAN}║   ${GREEN}✓${CYAN} Google Workspace (Gmail, Calendar)                     ║${NC}"
echo -e "${CYAN}║   ${GREEN}✓${CYAN} Atlassian (Jira, Confluence)                           ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║   ${YELLOW}This may take 5-10 minutes. Grab some coffee!${CYAN}           ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Prompt for Google secret upfront
echo -e "${YELLOW}Enter the Google OAuth Client Secret${NC}"
echo "(Sterling will give you this)"
echo ""
read -s -p "Client Secret: " GOOGLE_CLIENT_SECRET
echo ""
echo ""

if [ -z "$GOOGLE_CLIENT_SECRET" ]; then
    echo -e "${RED}Client secret is required. Ask Sterling for it.${NC}"
    exit 1
fi

echo -e "${GREEN}Got it! Starting installation...${NC}"
echo ""

# ============================================
# STEP 1: HOMEBREW
# ============================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Step 1/5: Installing Homebrew${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if command -v brew &> /dev/null; then
    echo -e "${GREEN}✓ Homebrew already installed${NC}"
else
    echo "Installing Homebrew (Mac package manager)..."
    echo ""
    echo -e "${YELLOW}You may be asked for your Mac password.${NC}"
    echo ""
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo -e "${GREEN}✓ Homebrew installed${NC}"
fi

echo ""

# ============================================
# STEP 2: NODE.JS
# ============================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Step 2/5: Installing Node.js${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✓ Node.js already installed ($NODE_VERSION)${NC}"
else
    echo "Installing Node.js..."
    brew install node
    echo -e "${GREEN}✓ Node.js installed${NC}"
fi

echo ""

# ============================================
# STEP 3: PYTHON
# ============================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Step 3/5: Installing Python${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if Python 3.10+ exists
NEED_PYTHON=1
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
    PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)

    if [ "$PYTHON_MAJOR" -ge 3 ] && [ "$PYTHON_MINOR" -ge 10 ]; then
        echo -e "${GREEN}✓ Python $PYTHON_VERSION already installed${NC}"
        NEED_PYTHON=0
    fi
fi

if [ $NEED_PYTHON -eq 1 ]; then
    echo "Installing Python 3.11..."
    brew install python@3.11
    echo -e "${GREEN}✓ Python installed${NC}"
fi

echo ""

# ============================================
# STEP 4: UV (Python package runner)
# ============================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Step 4/5: Installing UV${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if command -v uvx &> /dev/null; then
    echo -e "${GREEN}✓ UV already installed${NC}"
else
    echo "Installing UV..."
    brew install uv
    echo -e "${GREEN}✓ UV installed${NC}"
fi

echo ""

# ============================================
# STEP 5: CLAUDE CODE
# ============================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Step 5/5: Installing Claude Code${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if command -v claude &> /dev/null; then
    echo -e "${GREEN}✓ Claude Code already installed${NC}"
else
    echo "Installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
    echo -e "${GREEN}✓ Claude Code installed${NC}"
fi

echo ""

# ============================================
# CONFIGURE MCP SERVERS
# ============================================

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Configuring Connections${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Google Workspace
echo "Adding Google Workspace (Gmail, Calendar)..."
claude mcp remove google-workspace 2>/dev/null || true
claude mcp add google-workspace -s user \
    --env GOOGLE_OAUTH_CLIENT_ID="$GOOGLE_CLIENT_ID" \
    --env GOOGLE_OAUTH_CLIENT_SECRET="$GOOGLE_CLIENT_SECRET" \
    -- uvx workspace-mcp
echo -e "${GREEN}✓ Google Workspace configured${NC}"

# Atlassian
echo "Adding Atlassian (Jira, Confluence)..."
claude mcp remove atlassian 2>/dev/null || true
claude mcp add atlassian -s user --transport http https://mcp.atlassian.com/v1/mcp
echo -e "${GREEN}✓ Atlassian configured${NC}"

echo ""

# ============================================
# DONE!
# ============================================

clear
echo ""
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║   ${GREEN}🎉  Setup Complete!  🎉${CYAN}                                 ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║   You now have:                                            ║${NC}"
echo -e "${CYAN}║   ${GREEN}✓${CYAN} Claude Code - AI assistant in your terminal            ║${NC}"
echo -e "${CYAN}║   ${GREEN}✓${CYAN} Gmail & Calendar access                                ║${NC}"
echo -e "${CYAN}║   ${GREEN}✓${CYAN} Jira & Confluence access                               ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}HOW TO USE:${NC}"
echo ""
echo "  1. Open Terminal (you're already here!)"
echo ""
echo "  2. Type this command and press Enter:"
echo ""
echo -e "     ${YELLOW}claude${NC}"
echo ""
echo "  3. The first time, you'll need to log in:"
echo "     • Enter your Anthropic API key (or authenticate)"
echo "     • When you ask about email/calendar, log in with @postman.com"
echo "     • When you ask about Jira, log in with Atlassian"
echo ""
echo -e "${BLUE}TRY THESE:${NC}"
echo ""
echo -e "     ${YELLOW}\"What's on my calendar today?\"${NC}"
echo -e "     ${YELLOW}\"Show me my unread emails\"${NC}"
echo -e "     ${YELLOW}\"What are my open Jira tickets?\"${NC}"
echo -e "     ${YELLOW}\"Search Confluence for marketing docs\"${NC}"
echo ""
echo -e "${GREEN}Questions? Ask Sterling!${NC}"
echo ""
echo -e "${YELLOW}Tip: To start Claude Code anytime, just open Terminal and type: claude${NC}"
echo ""
