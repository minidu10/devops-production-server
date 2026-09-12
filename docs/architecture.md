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
## Reliability

The deployment process validates the application before restart and performs a health check after deployment.

Failed deployments trigger rollback.

## Backup and Recovery

Application files are backed up using backup.sh.

Backups are stored under:

    /var/backups/devops-app/

Only the five newest backups are retained.

Backups are automatically executed daily using a systemd timer.

A disaster recovery test was performed by intentionally corrupting the application and restoring it from a backup.

## Preflight Validation

preflight.sh verifies:

- Required commands
- Application service
- Nginx service
- Application HTTP health
- Nginx HTTP health
- UFW firewall

## Operational Commands

Check application:

    sudo systemctl status devops-app

View logs:

    sudo journalctl -u devops-app -f

Check server:

    ./scripts/server-status.sh

Run health check:

    ./scripts/health-check.sh

Run preflight:

    ./scripts/preflight.sh

Create backup:

    ./scripts/backup.sh

Check scheduled backups:

    systemctl list-timers devops-backup.timer
