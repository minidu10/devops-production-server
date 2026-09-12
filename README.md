# 🚀 Production Linux Server — DevOps Project

A production-style Linux server deployment project built to practice real-world DevOps workflows.

The project demonstrates how to deploy, operate, monitor, secure, back up, and recover a Python web application using Linux, systemd, Nginx, GitHub, Bash automation, UFW, and systemd timers.

---

## 🏗️ Architecture

```text
                         GitHub
                           │
                           │ git push
                           ▼
                  ┌─────────────────┐
                  │ Production      │
                  │ Linux Server    │
                  └────────┬────────┘
                           │
                      deploy.sh
                           │
                  ┌────────▼────────┐
                  │ Preflight Check │
                  └────────┬────────┘
                           │
                    Python Validation
                           │
                           ▼
                      systemd
                           │
                           ▼
                     Python App
                    127.0.0.1:8000
                           │
                           ▲
                           │
                      Nginx :80
                           │
                           ▼
                         Users


       ┌──────────────────────────────────────┐
       │              Operations              │
       ├──────────────────────────────────────┤
       │ Health Checks                        │
       │ Server Monitoring                    │
       │ systemd Journaling                   │
       │ UFW Firewall                         │
       │ Automated Backups                    │
       │ Backup Retention                     │
       │ Disaster Recovery                    │
       │ Automatic Deployment Rollback        │
       └──────────────────────────────────────┘
```

---

# 🎯 Project Objectives

The goal of this project is to build and operate a small production-style web server while learning practical DevOps concepts through implementation rather than theory.

The project focuses on:

* Linux server administration
* Git and GitHub
* Service management with systemd
* Reverse proxy configuration with Nginx
* Bash automation
* Application health checks
* Deployment automation
* Automatic rollback
* Server monitoring
* Centralized logging
* Firewall configuration
* Automated backups
* Disaster recovery
* Operational documentation

---

# 🛠️ Technology Stack

| Technology    | Purpose                    |
| ------------- | -------------------------- |
| Ubuntu Linux  | Server operating system    |
| Python        | Web application            |
| Git           | Version control            |
| GitHub        | Source code repository     |
| systemd       | Service management         |
| Nginx         | Reverse proxy              |
| Bash          | Automation                 |
| UFW           | Firewall                   |
| journald      | Application/system logging |
| systemd Timer | Scheduled backups          |
| curl          | Health testing             |

---

# 📁 Project Structure

```text
devops-project/
│
├── app/
│   └── app.py
│
├── config/
│   └── systemd/
│       └── devops-app.service
│
├── docs/
│   └── architecture.md
│
├── scripts/
│   ├── backup.sh
│   ├── deploy.sh
│   ├── health-check.sh
│   ├── server-status.sh
│   └── preflight.sh
│
└── .gitignore
```

---

# 🚀 Application

The application is a lightweight Python HTTP server.

It listens internally on:

```text
127.0.0.1:8000
```

The application is not directly exposed to users.

Nginx receives HTTP traffic on:

```text
:80
```

and forwards requests to the Python application.

Test the application directly:

```bash
curl http://localhost:8000
```

Test through Nginx:

```bash
curl http://localhost
```

Expected response:

```text
🚀 My DevOps Server

Application is running!
```

---

# ⚙️ systemd Service

The Python application runs as a systemd service.

Service:

```text
devops-app.service
```

Check status:

```bash
sudo systemctl status devops-app
```

Start:

```bash
sudo systemctl start devops-app
```

Stop:

```bash
sudo systemctl stop devops-app
```

Restart:

```bash
sudo systemctl restart devops-app
```

Enable at boot:

```bash
sudo systemctl enable devops-app
```

---

# 🌐 Nginx

Nginx acts as the reverse proxy.

```text
Client
  │
  ▼
Nginx :80
  │
  ▼
Python :8000
```

This provides a separation between the public HTTP interface and the internal application.

Verify Nginx:

```bash
sudo systemctl status nginx
```

Test:

```bash
curl http://localhost
```

---

# 🩺 Health Checks

The project contains an application health-check script:

```bash
./scripts/health-check.sh
```

Example:

```text
✅ Application is healthy
```

The deployment process uses health validation after restarting the application.

---

# 🚀 Deployment Automation

Deployment is handled by:

```bash
./scripts/deploy.sh
```

The deployment workflow is:

```text
GitHub
   │
   ▼
Git Pull
   │
   ▼
Preflight Validation
   │
   ▼
Python Validation
   │
   ▼
Restart Application
   │
   ▼
Health Check
   │
   ├── SUCCESS
   │
   └── FAILURE
          │
          ▼
       Rollback
```

Run deployment:

```bash
./scripts/deploy.sh
```

A successful deployment ends with:

```text
✅ Application is healthy
✅ Deployment successful!
```

---

# 🔙 Automatic Rollback

The deployment system is designed to detect failed deployments.

If the application fails the post-deployment health check, the deployment process attempts to restore the previous working version.

This was deliberately tested by introducing a production failure into the application.

The failure was detected by the health check and the rollback mechanism was tested.

---

# 📊 Server Monitoring

Server health can be checked using:

```bash
./scripts/server-status.sh
```

The script checks:

* Application status
* Nginx status
* Application health
* Nginx health
* Disk usage
* Memory usage
* System uptime
* Listening ports

Example:

```text
======================================
        DEVOPS SERVER STATUS
======================================

🔧 Application:
   ✅ devops-app is running

🌐 Nginx:
   ✅ nginx is running

🩺 Application Health:
   ✅ Python application responding

🌍 Nginx Health:
   ✅ Nginx responding
```

---

# 📝 Logging

Application logs are managed through systemd journald.

View recent logs:

```bash
sudo journalctl -u devops-app -n 20 --no-pager
```

Follow logs in real time:

```bash
sudo journalctl -u devops-app -f
```

Example application log:

```text
INFO GET request received: /
GET / HTTP/1.1" 200
INFO GET request completed: / 200
```

Journal storage is configured with a maximum disk usage limit.

---

# 🔐 Security

UFW is enabled as the host firewall.

Current public services:

```text
22/tcp   SSH
80/tcp   HTTP
```

The Python application listens internally:

```text
127.0.0.1:8000
```

Therefore, port `8000` is not exposed as a public application endpoint.

Check firewall:

```bash
sudo ufw status numbered
```

---

# 💾 Backups

Application backups are created using:

```bash
./scripts/backup.sh
```

Backups are stored in:

```text
/var/backups/devops-app/
```

Backup format:

```text
devops-app-YYYYMMDD-HHMMSS.tar.gz
```

The backup contains important project files while excluding unnecessary data such as:

* `.git`
* logs
* Python cache files

---

# ♻️ Backup Retention

The backup script keeps the **five newest backups**.

Older backups are automatically removed.

This prevents unlimited backup growth.

Check backups:

```bash
ls -lh /var/backups/devops-app/
```

---

# ⏰ Automated Backups

Backups are automatically scheduled using a systemd timer.

Service:

```text
devops-backup.service
```

Timer:

```text
devops-backup.timer
```

Check the timer:

```bash
systemctl status devops-backup.timer
```

List scheduled execution:

```bash
systemctl list-timers devops-backup.timer
```

The backup service runs automatically once per day.

---

# 🧯 Disaster Recovery

A disaster recovery test was performed.

The test simulated application corruption:

```text
Working Application
        │
        ▼
Application Corrupted
        │
        ▼
Service Failure
        │
        ▼
Backup Selected
        │
        ▼
Application Restored
        │
        ▼
Python Validation
        │
        ▼
systemd Restart
        │
        ▼
Health Check
        │
        ▼
✅ Recovery Successful
```

The application was successfully restored from the backup and returned to a healthy state.

---

# 🔍 Preflight Validation

Before deployment, the preflight script validates the server environment.

Run:

```bash
./scripts/preflight.sh
```

It checks:

* Required commands
* Python application
* systemd application service
* Nginx
* Application HTTP endpoint
* Nginx HTTP endpoint
* UFW firewall

A successful result:

```text
======================================
       DEVOPS PREFLIGHT CHECK
======================================

   ✅ git
   ✅ python3
   ✅ curl
   ✅ systemctl
   ✅ nginx

   ✅ devops-app
   ✅ nginx
   ✅ Application responding
   ✅ Nginx responding
   ✅ UFW active

======================================
✅ PREFLIGHT CHECK PASSED
======================================
```

---

# 🧪 Operational Testing

The project was tested against several failure scenarios.

### Application failure

```text
Application stopped
       ↓
systemd detects failure
       ↓
Service automatically restarted
```

### Broken deployment

```text
Broken version deployed
       ↓
Health check fails
       ↓
Rollback triggered
```

### Application corruption

```text
Application damaged
       ↓
Service fails
       ↓
Backup restored
       ↓
Application validated
       ↓
Service recovered
```

### Server monitoring

```text
Application       ✅
Nginx             ✅
HTTP              ✅
Disk              ✅
Memory            ✅
Uptime            ✅
Ports             ✅
```

---

# 📈 DevOps Concepts Demonstrated

This project demonstrates practical experience with:

```text
Linux Administration
        ↓
Process Management
        ↓
Service Management
        ↓
Reverse Proxy
        ↓
Version Control
        ↓
Deployment Automation
        ↓
Health Monitoring
        ↓
Failure Detection
        ↓
Rollback
        ↓
Backup
        ↓
Disaster Recovery
        ↓
Scheduled Automation
        ↓
Operational Documentation
```

---

# 🚀 Future Improvements

Possible future improvements include:

* Docker containerization
* CI/CD with GitHub Actions
* Container image versioning
* Container registry
* Prometheus monitoring
* Grafana dashboards
* Alerting
* Infrastructure as Code
* Cloud deployment
* Kubernetes orchestration
* Secrets management

These will be explored in subsequent DevOps projects.

---

# 👨‍💻 Author

**Minidu**

DevOps Engineering Learning Project

---

# 📌 Project Status

```text
Project 1 — Production Linux Server

Status: ✅ Completed

Linux                    ✅
Git/GitHub                ✅
systemd                   ✅
Nginx                     ✅
Reverse Proxy             ✅
Health Checks             ✅
Deployment Automation     ✅
Automatic Rollback        ✅
UFW Firewall              ✅
Monitoring                ✅
Logging                   ✅
Backup                    ✅
Backup Retention          ✅
Scheduled Backups         ✅
Disaster Recovery         ✅
Preflight Validation      ✅
Documentation             ✅
```
