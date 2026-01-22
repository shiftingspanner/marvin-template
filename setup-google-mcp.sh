#!/bin/bash
# Google Workspace MCP Setup Script
# DEPRECATED: Use setup-google-auth.sh instead
#
# The workspace-mcp package has a bug with the Tasks API scope.
# Use setup-google-auth.sh for a cleaner setup.
#
# Created by Sterling Chin

echo ""
echo "================================================"
echo "  NOTICE: This script is deprecated"
echo "================================================"
echo ""
echo "The workspace-mcp package has scope issues."
echo ""
echo "Please use the new setup script instead:"
echo ""
echo "  ./setup-google-auth.sh"
echo ""
echo "This provides the same Google Workspace access"
echo "without the Tasks API scope bug."
echo ""

read -p "Run the new setup script now? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    exec ./setup-google-auth.sh
fi
