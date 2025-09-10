# n8n Tailscale Setup Guide

This guide explains how to run n8n with Tailscale for secure remote access.

## Quick Start

Use the unified `n8n-tailscale` script to manage everything:

```bash
# Start with HTTP
./n8n-tailscale start

# Start with HTTPS (recommended)
./n8n-tailscale start-https

# Check status
./n8n-tailscale status

# View logs
./n8n-tailscale logs

# Stop n8n
./n8n-tailscale stop
```

## Access URLs

Once running, n8n is accessible at:
- **HTTPS**: `https://mac-studio.halfmoon-blenny.ts.net:5678` (no security warnings)
- **HTTP**: `http://mac-studio.halfmoon-blenny.ts.net:5678`
- **Local**: `http://localhost:5678`

## HTTPS Setup (Recommended)

### Prerequisites
1. Enable HTTPS in [Tailscale Admin Console](https://login.tailscale.com/admin/dns)
   - Go to DNS settings
   - Under "HTTPS Certificates", click "Enable HTTPS"
   - Accept that machine names will be public in certificate logs

2. Generate certificates (first time only):
```bash
tailscale cert mac-studio.halfmoon-blenny.ts.net
```

3. Start n8n with HTTPS:
```bash
./n8n-tailscale start-https
```

### Certificate Renewal
Certificates expire after 90 days. To renew:
```bash
./n8n-tailscale renew
```

## Configuration Files

### Environment Files
- `.env.https` - HTTPS configuration with SSL certificates
- `.env.tailscale` - HTTP configuration for Tailscale

Both files include:
- Updated environment variables (no deprecated warnings)
- Database connection pooling
- Task runners enabled
- Security settings configured

### Main Script: `n8n-tailscale`
A unified management script that handles:
- Starting n8n with HTTP or HTTPS
- Automatic certificate detection
- Status checking
- Log viewing
- Certificate renewal

### Command Reference

```bash
# Start commands
./n8n-tailscale start              # Start with HTTP
./n8n-tailscale start-https         # Start with HTTPS
./n8n-tailscale start -b            # Start in background

# Management commands
./n8n-tailscale status              # Show current status
./n8n-tailscale stop                # Stop n8n
./n8n-tailscale restart             # Restart n8n
./n8n-tailscale logs                # Follow logs

# Certificate management
./n8n-tailscale renew               # Renew HTTPS certificates
```

## Webhook Configuration

Webhooks are automatically configured with the correct Tailscale URL:
- **HTTPS**: `https://mac-studio.halfmoon-blenny.ts.net:5678/webhook/...`
- **HTTP**: `http://mac-studio.halfmoon-blenny.ts.net:5678/webhook/...`

## Docker Alternative

For containerized deployment, use `docker-compose.tailscale.yml`:

```bash
docker-compose -f docker-compose.tailscale.yml up -d
```

## Troubleshooting

### Certificate Issues
- Ensure HTTPS is enabled in Tailscale admin console
- Check certificate expiry: `./n8n-tailscale status`
- Renew if needed: `./n8n-tailscale renew`

### Connection Issues
- Verify Tailscale is running: `tailscale status`
- Check n8n status: `./n8n-tailscale status`
- Review logs: `./n8n-tailscale logs`

### Port Already in Use
- Stop existing n8n: `./n8n-tailscale stop`
- Check for other processes: `lsof -i :5678`

## Security Notes

- HTTPS is recommended for production use
- Tailscale provides end-to-end encryption between devices
- Certificates are stored locally and never leave your machine
- Consider enabling n8n authentication for additional security

## Legacy Scripts (Deprecated)

The following scripts are replaced by `n8n-tailscale`:
- `start-n8n-tailscale.sh` → use `./n8n-tailscale start`
- `start-https.sh` → use `./n8n-tailscale start-https`
- `setup-https-tailscale.sh` → certificates now handled automatically
- `setup-tailscale-serve.sh` → not needed with direct HTTPS support

Keep them for reference but use the unified script for all operations.