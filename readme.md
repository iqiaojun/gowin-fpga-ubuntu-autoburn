# 高云 FPGA 快速烧录框架

本项目旨在简化在 Ubuntu 系统下烧录高云 FPGA 固件的繁琐操作。由于官方提供的烧录方式较为复杂，特别适合初学者使用。

## 背景与动机

最近在学习 FPGA，并准备进行软核验证。然而，在 Ubuntu 系统下，每次烧录固件都需要手动查找指定文件，并调用特定路径下的可执行文件执行操作，这一过程十分繁琐。因此，为了简化操作，我们使用了 `make` 和 `.sh` 文件来实现烧录的人性化处理。

## 原始烧录操作

```bash
sudo ./openFPGALoader -b tangnano9k -f ../../nano9k_lcd/impl/pnr/Tang_nano_9K_LCD.fs
其中：

-b 表示目标板型号，具体可以参考下面的表格
-f 表示下载到 flash，不加的话会下载到 SRAM 中
最后的参数是需要烧录的文件，应该找到对应目录下的 .fs 文件
成功执行后将会输出如下 log：

write to flash
Jtag frequency: requested 6.00MHz -> real 6.00MHz  
Parse file Parse ../../nano9k_lcd/impl/pnr/Tang_nano_9K_LCD.fs: 
Done
DONE
Jtag frequency: requested 2.50MHz -> real 2.00MHz  
erase SRAM Done
erase Flash Done
write Flash: [==================================================] 100.00%
Done
CRC check: Success
项目功能与使用
我们编写了一个 makefile 文件，用于提取一些信息。需要注意，如果您的系统中的信息与 makefile 中的信息不同，则需要自行适配，例如 openFPGALoader 路径等。

使用该框架后，您只需在完成硬件电路的创建、综合、约束和布局布线后，即可生成可烧录的固件，连接硬件并运行 make SRAM 或 make flash 即可将固件烧录到指定位置。

自动化脚本
尽管基本实现了自动化，但仍需要手动打开文件并进行复制操作，这一点十分反人类。由于每次都会新创建一个工程，因此我们编写了一个 auto_burn.sh 脚本来实现一系列自动化操作，并在 .zshrc 文件中添加了如下定义：

bash
alias fpga_auto_burn="~/tmp/FPGA/project/20k/auto_burn.sh"
# 建议同时添加 Gowin IDE 的快速启动命令
alias gowin="~/IDE/Gowin_V1.9.9Beta-4_Education/IDE/bin/gw_ide"
这样，在命令行中只需运行 fpga_auto_burn 即可自动烧录程序。之后，您将自动进入最新创建的工程下，复制 makefile 文件到该工程内，并运行 make 检查设备。接着，您可以运行 make SRAM 或 make flash 进行一键烧录。

希望这一系列操作可以帮助您简化烧录流程，让您更专注于 FPGA 的学习和应用。

如有任何问题或改进建议，欢迎提交 Issue 或联系我。
