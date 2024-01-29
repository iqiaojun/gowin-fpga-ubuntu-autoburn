# Makefile for programming FPGA using openFPGALoader

# 获取当前路径并赋值给变量
PWD := $(shell pwd)

# 定义变量
BINARY = ~/openFPGALoader/build/openFPGALoader
FPGA_TYPE = tangnano20k
PROJECT_PATH = $(PWD)
PROJECT_NAME = $(notdir $(shell pwd))

#$(info BINARY       : $(BINARY))
$(info FPGA_TYPE    : $(FPGA_TYPE))
#$(info PROJECT_PATH : $(PROJECT_PATH))
$(info PROJECT_NAME : $(PROJECT_NAME))
$(info -------------------------------------)
# 定义颜色代码
COLOR_GREEN=\033[0;92m
COLOR_YELLOW=\033[0;93m
COLOR_RESET=\033[0m # 恢复默认颜色

# 默认目标
all: detect_fpga

# 检测FPGA
detect_fpga:
	sudo $(BINARY) --detect

# 烧录程序到SRAM
SRAM:
	@echo Programming FPGA to "$(COLOR_YELLOW)SRAM...$(COLOR_RESET)"
	sudo $(BINARY) -b $(FPGA_TYPE) $(PROJECT_PATH)/impl/pnr/$(PROJECT_NAME).fs

# 烧录程序到Flash
flash:
	@echo Programming FPGA to "$(COLOR_GREEN)Flash...$(COLOR_RESET)"
	sudo $(BINARY) -b $(FPGA_TYPE) -f $(PROJECT_PATH)/impl/pnr/$(PROJECT_NAME).fs

help:
	@echo "Available targets:"
	@echo "  detect_fpga - Detect FPGA"
	@echo "  SRAM        - Program FPGA to SRAM"
	@echo "  flash       - Program FPGA to Flash"

