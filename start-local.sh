#!/bin/bash

# n8n Local Start Script
# This script starts n8n in either development or production mode

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Ensure we're using Node.js 22
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

MODE=${1:-dev}

echo -e "${BLUE}=== Starting n8n in $MODE mode ===${NC}"
echo ""

# Check Node.js version
NODE_VERSION=$(node --version)
echo -e "${GREEN}Node.js: ${NODE_VERSION}${NC}"

# Check if pnpm is available
if ! command -v pnpm &> /dev/null; then
    echo -e "${RED}Error: pnpm is not available${NC}"
    echo "Please run ./setup-local.sh first"
    exit 1
fi

case $MODE in
    dev)
        echo -e "${YELLOW}Starting n8n in development mode...${NC}"
        echo "This will auto-reload on code changes."
        echo ""
        echo -e "${BLUE}n8n will be available at: http://localhost:5678${NC}"
        echo ""
        echo "Press Ctrl+C to stop"
        echo ""
        pnpm dev
        ;;
        
    start|prod|production)
        echo -e "${YELLOW}Starting n8n in production mode...${NC}"
        echo ""
        echo -e "${BLUE}n8n will be available at: http://localhost:5678${NC}"
        echo ""
        echo "Press Ctrl+C to stop"
        echo ""
        pnpm start
        ;;
        
    tunnel)
        echo -e "${YELLOW}Starting n8n with tunnel (for webhooks)...${NC}"
        echo "This creates a public URL for testing webhooks."
        echo ""
        ./packages/cli/bin/n8n start --tunnel
        ;;
        
    *)
        echo "Usage: $0 [dev|start|tunnel]"
        echo ""
        echo "Modes:"
        echo "  dev     - Development mode with auto-reload (default)"
        echo "  start   - Production mode"
        echo "  tunnel  - Production mode with webhook tunnel"
        exit 1
        ;;
esac
