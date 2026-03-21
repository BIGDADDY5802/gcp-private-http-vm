# Lab 1 — GCP VM HTTP Deployment
**Student:** unknown  
**Project:** class-7-5  
**Instance:** class-7-5-instances  
**Date:** 2026-03-20  
**Result:** ✅ PASS (5/5)

---

## What Was Built

A GCP VM running a self-configuring web server that:
- Serves an Ops Panel dashboard at `/`
- Returns `ok` at `/healthz`
- Returns instance metadata JSON at `/metadata`

---

## Architecture

```
Internet
   │
   ▼
GCP Firewall (port 80, tag: http-server)
   │
   ▼
Nginx (port 80)
   ├── /              → /var/www/html/index.html (Ops Panel)
   ├── /healthz       → Flask (port 8080)
   └── /metadata      → Flask (port 8080)
```

---

## Startup Script Flow

1. `apt install` nginx, curl, jq, python3-full, gettext-base
2. Query GCP metadata API for instance name, zone, region, IPs, machine type
3. Write HTML template using `<<'EOF'` (quoted — bash touches nothing)
4. Use `envsubst` to substitute only named variables into the template
5. Install Flask in a Python venv at `/opt/venv`
6. Deploy Flask app at `/opt/app.py` serving `/healthz` and `/metadata`
7. Register Flask as a `systemd` service (`seir.service`) so it survives reboots
8. Configure nginx to proxy `/healthz` and `/metadata` to Flask

---

## Key Bugs Fixed & Lessons Learned

### 1. Firewall Rule Requires Network Tag
The `default-allow-http` rule only applies to VMs tagged `http-server`.  
Without the tag on the VM, traffic is blocked even if the rule exists.

### 2. `<<EOF` vs `<<'EOF'`
| Syntax | Bash behavior |
|---|---|
| `<<EOF` | Expands all `${}` — dangerous inside HTML/CSS |
| `<<'EOF'` | Bash touches nothing — safe for any file content |

The original script crashed because bash tried to interpret CSS and JS-style syntax like `${NGINX_STATE == "active" ? "status-ok" : "status-bad"}` as a bash variable — which is invalid.

### 3. Pre-compute Logic Before Templates
Bash ternary operators don't exist. Compute conditional values before the template:
```bash
if [[ "$NGINX_STATE" == "active" ]]; then
  NGINX_CLASS="status-ok"
else
  NGINX_CLASS="status-bad"
fi
```

### 4. `envsubst` — Professional Template Substitution
Write a static template with `<<'EOF'`, then substitute only the variables you choose:
```bash
envsubst '${PROJECT_ID} ${REGION} ${NGINX_CLASS}' \
  < /tmp/index.html.tmpl \
  > /var/www/html/index.html
```
Anything not in the list is left untouched — CSS, JS, everything else stays safe.

### 5. `set -euo pipefail` is a Circuit Breaker
One failed command kills the entire script. A curl 404 early in the script
caused everything after it (including writing `index.html`) to never run.

### 6. Gate Script vs Startup Script
| Script | Purpose | Runs where |
|---|---|---|
| `gate_gcp_vm_http_ok.sh` | Grades/checks the VM from outside | Local machine |
| Startup script | Sets up the VM on boot | Inside the VM |

### 7. Systemd Keeps Services Alive
Without a systemd service, Flask only runs while you're manually watching it.
With `seir.service`, the VM restarts Flask automatically on every boot.

---

## Gate Result

```
Lab 1 Gate Result: PASS

PASS: Homepage reachable (HTTP 200)
PASS: /healthz endpoint returned 'ok'
PASS: /metadata returned valid JSON
PASS: metadata contains instance_name
PASS: metadata contains region
```