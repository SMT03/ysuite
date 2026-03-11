# rtop - Rockchip Performance Monitor (Reference)

**rtop** is an open-source graphical performance monitor for Rockchip RK3566/68/88 processors, developed by [Q-engineering](https://qengineering.eu/). It provides a Qt5-based GUI dashboard and can complement YSuite's CLI monitoring tools.

![rtop screenshot](https://github.com/user-attachments/assets/7cace014-41de-4bfb-ba25-27138e74c6f3)

> **Note**: rtop is an independent third-party project, not part of YSuite. It is documented here as a reference for users who prefer a graphical interface alongside YSuite's CLI tools.

## Variants

- **Rock OS (original Radxa image)**: [Qengineering/rtop-KDE](https://github.com/Qengineering/rtop-KDE)
- **Ubuntu OS (Joshua Riek image)**: [Qengineering/rtop-Ubuntu](https://github.com/Qengineering/rtop-Ubuntu)

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

## Installing rtop

```bash
git clone https://github.com/Qengineering/rtop-KDE.git rtop
cd rtop
sudo chmod +x ./install_rtop.sh
sudo ./install_rtop.sh
```

If the `libQt5Widgets.so.5` library is missing:

```bash
sudo apt-get install libqt5widgets5
```

## Running rtop

```bash
rtop
```

If RGA bars are not visible, run with elevated privileges:

```bash
sudo /usr/local/bin/rtop
```

To avoid repeated password prompts, use `sudo visudo` to configure passwordless sudo for this binary.

If NPU bars are not visible, verify the NPU is enabled — refer to the appendix commands below.

## Monitored Metrics

| Metric | sysfs / proc path |
|--------|-------------------|
| CPU load | `/proc/stat` |
| CPU frequency | `/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq` |
| GPU load | `/sys/class/devfreq/fb000000.gpu/load` |
| GPU frequency | `/sys/class/devfreq/fb000000.gpu/cur_freq` |
| NPU load | `/sys/kernel/debug/rknpu/load` *(requires sudo)* |
| NPU frequency | `/sys/class/devfreq/fdab0000.npu/cur_freq` |
| RGA load | `/sys/kernel/debug/rkrga/load` *(requires sudo)* |
| RGA frequency | `/sys/kernel/debug/clk/clk_summary` |
| Memory / Swap | `/proc/meminfo` |
| Temperature | `/sys/class/thermal/thermal_zone0/temp` |
| Fan state | `/sys/class/thermal/cooling_device4/cur_state` |
| Device model | `/sys/firmware/devicetree/base/compatible` |

