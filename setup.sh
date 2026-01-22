#!/bin/bash

# MARVIN Setup Script
# Run this after cloning to initialize your MARVIN instance

echo "🤖 MARVIN Setup"
echo "==============="
echo ""

# Check if CLAUDE.md already exists
if [ -f "CLAUDE.md" ]; then
    echo "⚠️  CLAUDE.md already exists. Skipping copy."
    echo "   Delete it first if you want to start fresh."
else
    echo "📄 Creating CLAUDE.md from template..."
    cp CLAUDE.md.template CLAUDE.md
    echo "   ✓ Created CLAUDE.md"
    echo "   → Edit this file to customize MARVIN for you"
fi

# Create .gitkeep files to preserve directory structure
echo ""
echo "📁 Ensuring directory structure..."
mkdir -p sessions events
touch sessions/.gitkeep events/.gitkeep
echo "   ✓ Directories ready"

# Check if this is a git repo
echo ""
if [ -d ".git" ]; then
    echo "📦 Git repo detected"
else
    echo "📦 Initializing git repo..."
    git init
    echo "   ✓ Git initialized"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit CLAUDE.md - Replace all {{PLACEHOLDERS}} with your info"
echo "2. Edit state/goals.md - Define your goals for the year"
echo "3. Edit state/current.md - Add your current priorities"
echo "4. Run 'claude' in this directory and type '/marvin' to start"
echo ""
echo "See README.md for full documentation."
