#!/usr/bin/env python3
"""Google OAuth authentication for MARVIN template.

Sets up Google Workspace access with correct scopes for:
- Gmail (read/send)
- Google Calendar (read/write events)
- Google Drive (full access)
- Google Docs (read/write)
- Google Sheets (read/write)
- Google Slides (read/write)

Run with: python3 scripts/google_auth.py
Or via:   ./setup-google-auth.sh
"""

import argparse
import json
import sys
from pathlib import Path

from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow

# Google OAuth scopes - these are the correct, working scopes
GOOGLE_SCOPES = [
    "https://mail.google.com/",  # Full Gmail access
    "https://www.googleapis.com/auth/calendar.readonly",
    "https://www.googleapis.com/auth/calendar.events",
    "https://www.googleapis.com/auth/documents",
    "https://www.googleapis.com/auth/spreadsheets",
    "https://www.googleapis.com/auth/drive",
    "https://www.googleapis.com/auth/presentations",
]

# Get project root (parent of scripts/)
PROJECT_ROOT = Path(__file__).parent.parent


def get_credentials_path(account: str = "work") -> Path:
    """Get the path to store OAuth credentials."""
    return PROJECT_ROOT / f"credentials_{account}.json"


def get_client_secret_path(account: str = "work") -> Path:
    """Get the path to the client secret file."""
    return PROJECT_ROOT / f"client_secret_{account}.json"


def create_client_secret(client_id: str, client_secret: str, account: str = "work") -> Path:
    """Create a client_secret JSON file from ID and secret."""
    client_secret_data = {
        "installed": {
            "client_id": client_id,
            "client_secret": client_secret,
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "redirect_uris": ["http://localhost"]
        }
    }

    path = get_client_secret_path(account)
    with open(path, "w") as f:
        json.dump(client_secret_data, f, indent=2)

    print(f"Created {path}")
    return path


def authenticate(account: str = "work", force: bool = False) -> Credentials:
    """Run the OAuth flow and save credentials."""
    creds = None
    credentials_path = get_credentials_path(account)
    client_secret_path = get_client_secret_path(account)

    # Remove existing credentials if forcing re-auth
    if force and credentials_path.exists():
        print(f"Removing existing credentials for {account}...")
        credentials_path.unlink()

    # Load existing credentials if available
    if credentials_path.exists():
        creds = Credentials.from_authorized_user_file(str(credentials_path), GOOGLE_SCOPES)

    # Refresh or get new credentials if needed
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            print(f"Refreshing expired credentials for {account}...")
            try:
                creds.refresh(Request())
            except Exception as e:
                print(f"Refresh failed: {e}")
                print("Starting fresh OAuth flow...")
                creds = None

        if not creds or not creds.valid:
            if not client_secret_path.exists():
                print(f"\nError: {client_secret_path} not found.")
                print("\nYou need to set up Google OAuth credentials first.")
                print("Run this script with --setup flag to configure.")
                sys.exit(1)

            print(f"\nStarting OAuth flow for {account}...")
            print("A browser window will open for you to authorize access.")
            print("\nScopes being requested:")
            for scope in GOOGLE_SCOPES:
                print(f"  - {scope.split('/')[-1]}")
            print()

            flow = InstalledAppFlow.from_client_secrets_file(
                str(client_secret_path), GOOGLE_SCOPES
            )
            creds = flow.run_local_server(port=0)

        # Save credentials
        with open(credentials_path, "w") as f:
            f.write(creds.to_json())
        print(f"\nCredentials saved to {credentials_path}")

    return creds


def check_credentials(account: str = "work") -> bool:
    """Check if valid credentials exist."""
    credentials_path = get_credentials_path(account)

    if not credentials_path.exists():
        return False

    try:
        creds = Credentials.from_authorized_user_file(str(credentials_path), GOOGLE_SCOPES)
        if creds and creds.valid:
            return True
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
            return creds.valid
    except Exception:
        return False

    return False


def setup_wizard():
    """Interactive setup wizard for Google OAuth."""
    print()
    print("=" * 50)
    print("  Google Workspace Setup Wizard")
    print("=" * 50)
    print()
    print("This will set up Google OAuth for:")
    print("  - Gmail")
    print("  - Google Calendar")
    print("  - Google Drive")
    print("  - Google Docs")
    print("  - Google Sheets")
    print("  - Google Slides")
    print()

    # Check if using shared credentials or own project
    print("Do you have Google OAuth credentials?")
    print("  1. Yes, I have a Client ID and Client Secret")
    print("  2. No, I need to create them")
    print()

    choice = input("Enter choice (1 or 2): ").strip()

    if choice == "2":
        print()
        print("To create Google OAuth credentials:")
        print()
        print("  1. Go to https://console.cloud.google.com")
        print("  2. Create a new project (or select existing)")
        print("  3. Go to 'APIs & Services' > 'Enabled APIs'")
        print("  4. Enable these APIs:")
        print("     - Gmail API")
        print("     - Google Calendar API")
        print("     - Google Drive API")
        print("     - Google Docs API")
        print("     - Google Sheets API")
        print("     - Google Slides API")
        print("  5. Go to 'APIs & Services' > 'Credentials'")
        print("  6. Click 'Create Credentials' > 'OAuth client ID'")
        print("  7. Choose 'Desktop application'")
        print("  8. Copy the Client ID and Client Secret")
        print()
        input("Press Enter when you have your credentials...")
        print()

    # Get credentials
    print("Enter your Google OAuth credentials:")
    print()
    client_id = input("Client ID: ").strip()
    client_secret = input("Client Secret: ").strip()

    if not client_id or not client_secret:
        print("\nError: Both Client ID and Client Secret are required.")
        sys.exit(1)

    # Ask which account
    print()
    print("Which account is this for?")
    print("  1. work (recommended for @company.com accounts)")
    print("  2. personal")
    print()
    account_choice = input("Enter choice (1 or 2) [1]: ").strip() or "1"
    account = "work" if account_choice == "1" else "personal"

    # Create client secret file
    print()
    create_client_secret(client_id, client_secret, account)

    # Run OAuth flow
    print()
    print("Now let's authenticate with Google...")
    print()

    creds = authenticate(account)

    if creds and creds.valid:
        print()
        print("=" * 50)
        print("  Setup Complete!")
        print("=" * 50)
        print()
        print(f"You're now authenticated as {account}.")
        print()
        print("You can now use Google Workspace with Claude Code!")
        print()
    else:
        print("\nSetup failed. Please try again.")
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser(
        description="Google OAuth setup for MARVIN",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 scripts/google_auth.py --setup     # Interactive setup wizard
  python3 scripts/google_auth.py --check     # Check if authenticated
  python3 scripts/google_auth.py --auth      # Run OAuth flow
  python3 scripts/google_auth.py --force     # Force re-authentication
        """
    )
    parser.add_argument("--setup", action="store_true", help="Run interactive setup wizard")
    parser.add_argument("--auth", action="store_true", help="Run OAuth authentication")
    parser.add_argument("--check", action="store_true", help="Check authentication status")
    parser.add_argument("--force", action="store_true", help="Force re-authentication")
    parser.add_argument("--account", choices=["work", "personal"], default="work",
                        help="Which account to use (default: work)")

    args = parser.parse_args()

    if args.setup:
        setup_wizard()
    elif args.check:
        if check_credentials(args.account):
            print(f"Authenticated for {args.account}")
        else:
            print(f"Not authenticated for {args.account}")
            sys.exit(1)
    elif args.auth or args.force:
        authenticate(args.account, force=args.force)
        print(f"\nAuthentication successful for {args.account}!")
    else:
        # Default: check status and prompt if needed
        if check_credentials(args.account):
            print(f"Already authenticated for {args.account}")
        else:
            print(f"Not authenticated for {args.account}")
            print("Run with --setup for interactive wizard or --auth to authenticate")


if __name__ == "__main__":
    main()
