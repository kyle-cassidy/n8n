#!/bin/bash

# n8n Local Development Setup Script
# This script sets up n8n for local development

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== n8n Local Development Setup ===${NC}"
echo ""

# Ensure we're using Node.js 22
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# Check Node.js version
NODE_VERSION=$(node --version)
echo -e "${GREEN}✓ Node.js version: ${NODE_VERSION}${NC}"

# Check if Node.js version is at least 22.16
NODE_MAJOR=$(echo $NODE_VERSION | cut -d. -f1 | sed 's/v//')
if [ "$NODE_MAJOR" -lt 22 ]; then
    echo -e "${RED}Error: Node.js version 22.16 or newer is required${NC}"
    echo "Current version: $NODE_VERSION"
    exit 1
fi

# Check corepack
echo -e "${YELLOW}Setting up corepack...${NC}"
corepack enable
corepack prepare --activate
echo -e "${GREEN}✓ Corepack enabled${NC}"

# Check if pnpm is available
if ! command -v pnpm &> /dev/null; then
    echo -e "${RED}Error: pnpm is not available${NC}"
    exit 1
fi

PNPM_VERSION=$(pnpm --version)
echo -e "${GREEN}✓ pnpm version: ${PNPM_VERSION}${NC}"

# Install dependencies
echo ""
echo -e "${YELLOW}Installing dependencies (this may take a while)...${NC}"
pnpm install

echo -e "${GREEN}✓ Dependencies installed${NC}"

# Build n8n
echo ""
echo -e "${YELLOW}Building n8n (this may take a while)...${NC}"
pnpm build

echo -e "${GREEN}✓ n8n built successfully${NC}"

echo ""
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo ""
echo "You can now start n8n with:"
echo -e "${BLUE}  Development mode:  pnpm dev${NC}"
echo -e "${BLUE}  Production mode:   pnpm start${NC}"
echo ""
echo "n8n will be available at: http://localhost:5678"
echo ""
echo "Note: Make sure to run this in a terminal where you've set:"
echo '  export PATH="/opt/homebrew/opt/node@22/bin:$PATH"'
