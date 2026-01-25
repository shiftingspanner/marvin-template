# Microsoft 365 Integration

Connect Claude Code to Microsoft 365 (Outlook, Calendar, OneDrive, Teams, SharePoint, etc.)

## Setup

```bash
./.marvin/integrations/ms365/setup.sh
```

## What You Get

- **Outlook** - Read, send, and manage emails
- **Calendar** - View and create events
- **OneDrive** - Access and manage files
- **Teams** - Read channels and messages
- **SharePoint** - Access sites and documents
- **To Do** - Manage tasks
- **OneNote** - Access notebooks
- **Planner** - View and manage plans

## Authentication

Uses Microsoft's device flow authentication:
1. First request opens a browser prompt
2. Enter the device code shown
3. Sign in with your Microsoft account
4. Tokens are cached for future sessions

No API keys or client secrets required.

## Account Types

The `--org-mode` flag enables both:
- Work/School accounts (Microsoft 365 Business)
- Personal Microsoft accounts (outlook.com, hotmail.com)

## Manual Setup

If you prefer to set up manually:

```bash
claude mcp add ms365 -s user -- npx -y @softeria/ms-365-mcp-server --org-mode
```

## Troubleshooting

**"Failed to connect" error:**
- Run `claude mcp remove ms365 -s user` and re-run setup
- Make sure Node.js is installed

**Authentication issues:**
- Clear cached tokens by removing `~/.ms365-mcp/` directory
- Re-authenticate on next request

**"Need admin approval" error (Work/School accounts):**

This MCP requests broad permissions including Teams, SharePoint, and directory access. Many organizations require admin consent for these scopes.

Your options:
1. **Get admin consent** - Ask your IT admin to approve the app, or grant yourself admin rights if you're an admin
2. **Use a personal Microsoft account** - Personal accounts (outlook.com, hotmail.com) don't require admin consent
3. **Wait for a minimal-scopes version** - A fork with reduced permissions for just Mail, Calendar, and OneDrive is being considered

Scopes that typically require admin consent:
- `User.Read.All`, `Sites.Read.All`, `Files.Read.All`
- All Teams/Chat scopes (`Team.ReadBasic.All`, `Channel.ReadBasic.All`, etc.)

## More Info

- MCP Package: [@softeria/ms-365-mcp-server](https://www.npmjs.com/package/@softeria/ms-365-mcp-server)
