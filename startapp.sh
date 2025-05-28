#!/bin/bash

cd /AVDC || exit 1

# 无限循环：主程序结束后触发重启按钮窗口
while true; do
  # 运行主程序
  python3 AVDC_Main.py

  # 显示重启按钮窗口（阻塞，直到按钮点击）
  python3 wait_restart.py

  # 按钮点击后循环继续，重启主程序
done

