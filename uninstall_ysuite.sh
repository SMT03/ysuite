#!/bin/bash
# YSuite Uninstallation Script
# Comprehensive Rock 5B+ Monitoring and Management Suite
set -e
echo "YSuite - Rock 5B+ Monitoring Suite Uninstallation"
echo "=================================================="
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

echo "Removing YSuite command symlinks..."
# Remove symlinks
if [ -L "/usr/local/bin/ytop" ]; then
    rm -f /usr/local/bin/ytop
    echo "  ✅ Removed ytop symlink"
else
    echo "  ⚠️  ytop symlink not found"
fi

if [ -L "/usr/local/bin/ylog" ]; then
    rm -f /usr/local/bin/ylog
    echo "  ✅ Removed ylog symlink"
else
    echo "  ⚠️  ylog symlink not found"
fi

if [ -L "/usr/local/bin/ycrash" ]; then
    rm -f /usr/local/bin/ycrash
    echo "  ✅ Removed ycrash symlink"
else
    echo "  ⚠️  ycrash symlink not found"
fi

if [ -L "/usr/local/bin/ypower" ]; then
    rm -f /usr/local/bin/ypower
    echo "  ✅ Removed ypower symlink"
else
    echo "  ⚠️  ypower symlink not found"
fi

if [ -L "/usr/local/bin/yhelp" ]; then
    rm -f /usr/local/bin/yhelp
    echo "  ✅ Removed yhelp symlink"
else
    echo "  ⚠️  yhelp symlink not found"
fi

echo "Removing YSuite main binary..."
# Remove main binary
if [ -f "/usr/local/bin/ysuite" ]; then
    rm -f /usr/local/bin/ysuite
    echo "  ✅ Removed ysuite binary"
else
    echo "  ⚠️  ysuite binary not found"
fi

echo "Removing YSuite data directories..."
# Remove directories (with confirmation for data directories)
if [ -d "/var/log/ysuite" ]; then
    rm -rf /var/log/ysuite
    echo "  ✅ Removed /var/log/ysuite directory"
else
    echo "  ⚠️  /var/log/ysuite directory not found"
fi

if [ -d "/etc/ysuite" ]; then
    rm -rf /etc/ysuite
    echo "  ✅ Removed /etc/ysuite directory"
else
    echo "  ⚠️  /etc/ysuite directory not found"
fi

# Ask before removing data directory (contains user data)
if [ -d "/var/lib/ysuite" ]; then
    echo ""
    echo "⚠️  Data directory /var/lib/ysuite contains user data."
    read -p "Remove data directory /var/lib/ysuite? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf /var/lib/ysuite
        echo "  ✅ Removed /var/lib/ysuite directory"
    else
        echo "  ℹ️  Kept /var/lib/ysuite directory"
    fi
else
    echo "  ⚠️  /var/lib/ysuite directory not found"
fi

echo "Checking for systemd services..."
# Check for any systemd services (though none are created by install script)
if [ -f "/etc/systemd/system/ysuite.service" ]; then
    systemctl stop ysuite.service 2>/dev/null || true
    systemctl disable ysuite.service 2>/dev/null || true
    rm -f /etc/systemd/system/ysuite.service
    systemctl daemon-reload
    echo "  ✅ Removed ysuite systemd service"
fi

echo ""
echo "✅ YSuite uninstallation completed!"
echo ""
echo "Note: Python dependencies (python3-psutil, python3-requests, etc.) were not removed"
echo "      as they may be used by other applications. Remove manually if needed:"
echo "      sudo apt remove python3-psutil python3-requests python3-rich python3-colorama"
echo ""
echo "Note: rkmpp was not removed as it may be used by other applications."
echo "      Remove manually if no longer needed: sudo apt remove rkmpp"