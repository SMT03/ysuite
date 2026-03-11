# YSuite - Comprehensive Rock 5B+ Monitoring and Management Suite

A unified package for headless Radxa ROCK 5B+ systems with real-time monitoring, crash detection, power management, and system optimization. Built specifically for the Rockchip RK3588 SoC.

## Features

### **ytop** - Real-time System Performance Monitor
- **CPU**: 8-core monitoring (4x Cortex-A76 @ 2.2-2.4GHz, 4x Cortex-A55 @ 1.8GHz) with per-core frequency and load tracking
- **GPU**: Arm Mali-G610 MC4 load and frequency monitoring via devfreq
- **NPU**: 6 TOPS AI accelerator monitoring with RKNPU2 process detection
- **RGA**: 3-core Rockchip Graphics Accelerator load tracking
- **VPU**: Video Processing Unit monitoring via devfreq (8K@60fps decode/8K@30fps encode)
- **Memory**: LPDDR5 RAM monitoring (4GB-32GB @ 5500MT/s)
- **Temperature**: SoC thermal zone monitoring with 80°C throttling detection
- **Fan Control**: PWM-based cooling management
- Interactive CLI dashboard with real-time progress bars

### **ylog** - System Log Monitor
- Real-time critical event detection
- JSON-structured log storage
- Pattern-based error classification

### **ycrash** - Crash Detection and Analysis
- Kernel crash detection
- Segmentation fault monitoring
- OOM and system panic tracking

### **ypower** - Power Monitoring and PD Negotiation
- Multi-source power detection (USB PD, ADC, barrel jack)
- Real-time voltage/current monitoring
- USB-C PD 3A current negotiation

## Installation

### Quick Install
```bash
sudo ./install_ysuite.sh
```

### Direct Board Installation
```bash
# Copy the repository files to your Rock 5B+ board (via USB, SD card, or scp), then run:
sudo ./install_ysuite.sh
```

## Usage

### Get Help
```bash
yhelp
```

### Basic Commands
```bash
# Real-time system monitoring
ytop

# Monitor system logs
ylog

# Check for crashes
ycrash

# Monitor power
ypower
```

## Package Contents

- **ysuite.py** - Main Python script with all RK3588 hardware monitoring functionality
- **install_ysuite.sh** - Installation script with dependency checking
- **uninstall_ysuite.sh** - Clean removal script

## Requirements

### Hardware
- **Board**: Radxa ROCK 5B+ (Pico-ITX form factor)
- **SoC**: Rockchip RK3588 (8nm process)
  - 4x Arm Cortex-A76 @ 2.2-2.4GHz + 4x Arm Cortex-A55 @ 1.8GHz
  - Arm Mali-G610 MC4 GPU with OpenGL ES 3.2 / Vulkan 1.2 support
  - 6 TOPS NPU (INT4/INT8/INT16/FP16 support)
- **Memory**: 4GB to 32GB LPDDR5 @ 5500MT/s
- **Power**: USB-C PD (9V/12V/15V/20V) or 5-20V, minimum 24W (40W with NVMe SSD)

### Software
- **OS**: Debian/Ubuntu Linux (Radxa official images recommended)
- **Python**: 3.8+
- **Kernel**: Linux with sysfs and devfreq support
- **Drivers**:
  - Mali GPU drivers (Panfrost open-source or proprietary Mali blob)
  - rkmpp (Rockchip Media Process Platform) for VPU monitoring
  - Standard thermal and devfreq drivers
- **Access**: Root/sudo privileges for hardware monitoring

### Optional
- `jellyfin-ffmpeg` for enhanced video processing detection
- `lm-sensors` for additional temperature monitoring
- Fan with PWM connector for automated cooling

## Kernel Logging

This suite provides structured kernel logging with improvements over the default Radxa Rock 5B+ error logging approach:

- **Error Severity Levels**: Critical / Error / Warning / Info / Debug classification
- **Pattern Recognition**: Hardware-specific regex patterns for RK3588 components
- **Real-time Monitoring**: Live event detection during runtime
- **Structured Storage**: JSON log format with metadata for easy parsing and analysis
- **Automated Log Management**: Rotation and cleanup without manual intervention
