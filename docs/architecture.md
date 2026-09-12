# DevOps Production Server

## Architecture

Internet
   |
   v
Nginx :80
   |
   v
Python Application
127.0.0.1:8000
   |
   v
systemd

## Components

- Ubuntu Linux / WSL
- Git
- GitHub
- systemd
- Python HTTP server
- Nginx
- UFW
- journald
- Bash deployment scripts

## Deployment Flow

1. Developer pushes code to GitHub.
2. Server pulls latest code.
3. Python application is validated.
4. systemd restarts the application.
5. Health check verifies the application.
6. Failed deployments trigger rollback.
7. Successful deployments record the production commit.

## Security

- UFW enabled.
- SSH allowed.
- HTTP allowed.
- Python application bound to localhost.
- Application port 8000 is not publicly exposed.

## Monitoring

The server-status.sh script checks:

- Application status
- Nginx status
- Application health
- HTTP health
- Disk usage
- Memory
- Uptime
- Listening ports

## Logging

Application logs are collected through systemd-journald.

Example:

    sudo journalctl -u devops-app -f
