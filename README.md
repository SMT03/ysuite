# YSuite - Comprehensive Rock 5B+ Monitoring and Management Suite

A unified package for headless Radxa ROCK 5B+ systems with real-time monitoring, crash detection, power management, and system optimization. Built specifically for the Rockchip RK3588 SoC with support for its advanced hardware features.

##  Features

### **ytop** - Real-time System Performance Monitor
- **CPU**: 8-core monitoring (4x Cortex-A76 @ 2.2-2.4GHz, 4x Cortex-A55 @ 1.8GHz) with per-core frequency and load tracking
- **GPU**: Arm Mali-G610 MC4 load and frequency monitoring via devfreq
- **NPU**: 6 TOPS AI accelerator monitoring with RKNPU2 process detection
- **RGA**: 3-core Rockchip Graphics Accelerator load tracking
- **VPU**: Video Processing Unit monitoring via devfreq (8K@60fps decode/8K@30fps encode)
- **Memory**: LPDDR5 RAM monitoring (4GB-32GB @ 5500MT/s)
- **Temperature**: SoC thermal zone monitoring with 80°C throttling detection
- **Fan Control**: PWM-based cooling management
- Beautiful CLI dashboard with real-time progress bars

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
- Aggressive 3A current negotiation

##  Installation

### Quick Install
```bash
# Download and install YSuite
sudo ./install_ysuite.sh
```

### Uninstall
```bash
# Remove YSuite completely
sudo ./uninstall_ysuite.sh
```

### Direct Board Installation
```bash
# Copy files to your Rock 5B+ board (via USB, SD card, or direct transfer)
# Then on the board, run:
sudo ./install_ysuite.sh
```

##  Usage

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

- **ysuite.py** - Main Python script with comprehensive RK3588 hardware monitoring
  - CPU: Per-core load/frequency via `/proc/stat` and cpufreq
  - GPU: Mali-G610 monitoring via `/sys/class/devfreq/fb000000.gpu-mali`
  - NPU: RKNPU2 process detection and load estimation
  - RGA: 3-core graphics accelerator monitoring
  - VPU: Video processing via `/sys/class/devfreq/fdea0000.vpu`
  - Memory: LPDDR5 usage tracking via `/proc/meminfo`
  - Thermal: SoC temperature zones via `/sys/class/thermal`
  - Power: USB-C PD and SARADC_IN4 voltage monitoring
- **install_ysuite.sh** - Installation script with dependency checking
- **uninstall_ysuite.sh** - Clean removal script
- **deploy_ysuite.sh** - Deployment guide and instructions
- **scripts/** - Helper scripts for kernel optimization and Mali driver management

## Requirements

### Hardware
- **Board**: Radxa ROCK 5B+ (Pico-ITX form factor)
- **SoC**: Rockchip RK3588 (8nm process)
  - 4x Arm Cortex-A76 @ 2.2-2.4GHz + 4x Arm Cortex-A55 @ 1.8GHz
  - Arm Mali-G610 MC4 GPU with OpenGL/Vulkan support
  - 6 TOPS NPU (INT4/INT8/INT16/FP16 support)
- **Memory**: 4GB to 32GB LPDDR5 @ 5500MT/s
- **Storage**: eMMC (16GB-256GB), microSD, or M.2 NVMe SSD
- **Power**: USB-C PD (9V/12V/15V/20V) or 5-20V, min 24W (40W with SSD)
- **Cooling**: Optional PWM fan for thermal management

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
- jellyfin-ffmpeg for enhanced video processing detection
- lm-sensors for additional temperature monitoring
- Fan with PWM connector for automated cooling

## Hardware Monitoring Details

### CPU Architecture (RK3588)
- **big.LITTLE configuration**: 4x A76 (high-performance) + 4x A55 (efficiency)
- **Monitoring**: Per-core utilization via `mpstat`, frequency scaling via cpufreq
- **Load tracking**: `/proc/loadavg` for system averages, `/proc/stat` for per-core stats
- **Instruction set**: Armv8 with advanced monitoring extensions

### GPU (Arm Mali-G610 MC4)
- **APIs**: OpenGL ES 3.2, OpenCL 2.2, Vulkan 1.2
- **Drivers**: Panfrost (open-source, mainline) or proprietary Mali blob
- **Monitoring paths**:
  - Load: `/sys/class/devfreq/fb000000.gpu-mali/load`
  - Frequency: `/sys/class/devfreq/fb000000.gpu-mali/cur_freq`
  - DRM stats: `/sys/class/drm/card0/device/gpu_busy_percentage`
- **Video**: 8K@60fps H.265/H.264/VP9/AV1 decode, 8K@30fps H.264/H.265 encode

### NPU (Neural Processing Unit)
- **Performance**: 6 TOPS AI computing
- **Data types**: INT4/INT8/INT16/FP16/BF16/TF32
- **Software**: RKNPU2 stack for inference
- **Monitoring**: Process detection for RKNN services

### RGA (Rockchip Graphics Accelerator)
- **Cores**: 3x independent RGA units
- **Purpose**: 2D acceleration, image processing
- **Monitoring**: Load tracking via sysfs (implementation-dependent)

### VPU (Video Processing Unit)
- **Decode**: 8K@60fps (H.265/H.264/VP9/AV1/AVS2)
- **Encode**: 8K@30fps (H.264/H.265)
- **Monitoring paths**:
  - Load: `/sys/class/devfreq/fdea0000.vpu/load`
  - Frequency: `/sys/class/devfreq/fdea0000.vpu/cur_freq`
  - Debug: `/sys/kernel/debug/rkvdec*/load` (if enabled)

### Memory (LPDDR5)
- **Speed**: 5500MT/s (64-bit bus)
- **Capacity**: 4GB/8GB/16GB/24GB/32GB options
- **Monitoring**: `/proc/meminfo` for detailed stats, `free -h` for quick view
- **Low latency**: Ideal for real-time monitoring applications

### Thermal Management
- **SoC sensors**: `/sys/class/thermal/thermal_zone*/temp`
- **Throttling**: Automatic at 80°C internal temperature
- **Fan control**: PWM via 2-pin 1.25mm connector (5V)
- **Operating range**: 0°C to 50°C ambient

### Power Monitoring
- **Input**: USB-C PD (9V/12V/15V/20V) or 5-20V fixed
- **Consumption**: 24W minimum, 40W with NVMe SSD
- **Voltage sensing**: SARADC_IN4 (1.8V ADC) on GPIO pin 22
- **GPIO power**: Pins 2/4 provide 5V supply

### Storage and I/O
- **eMMC**: 16GB to 256GB onboard modules
- **M.2 NVMe**: Dual PCIe 3.0 x2 (16Gbps) via M-Key connectors
- **Network**: 2.5GbE + Wi-Fi 6 + BLE 5.2 + optional 4G/5G
- **Monitoring**: `df -h`, `iotop`, `nvme` CLI for health checks

### GPIO and Interfaces
- **40-pin header**: 3.3V logic (most pins), 1.8V for SARADC_IN4
- **Functions**: I2C, SPI, PWM, UART, I2S, PCM, SPDIF
- **Custom sensors**: Temperature, voltage, current via I2C/ADC
- **Fan PWM**: Automated cooling based on load/temperature

