
FROM jlesage/baseimage-gui:ubuntu-22.04-v4

# 替换阿里云镜像源
RUN sed -i "s@http://.*archive.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@http://mirrors.aliyun.com@g" /etc/apt/sources.list

# 配置 pip 国内镜像源
RUN mkdir -p /root/.pip && \
    echo '[global]' > /root/.pip/pip.conf && \
    echo 'index-url = https://mirrors.aliyun.com/pypi/simple/' >> /root/.pip/pip.conf && \
    echo 'trusted-host = mirrors.aliyun.com' >> /root/.pip/pip.conf

# 环境变量
ENV ENABLE_CJK_FONT=1
ENV APP_NAME="AVDC Console"
# 设置默认语言环境为 UTF-8（中文或英文）
ENV LANG=zh_CN.UTF-8
ENV LC_TIME=en_US.UTF-8

# 系统级依赖安装
RUN apt-get update && \
    apt-get install -y \
    locales \
    python3 \
    python3-pip \
    python3-pyqt5 \
    libgl1-mesa-glx \
    libxcb-xinerama0 \
    # 添加图像处理库
    libopenjp2-7 \
    libtiff5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 中文字体安装
RUN add-pkg fonts-wqy-zenhei

# 生成 UTF-8 语言环境（中文或英文均可）
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen

# Python依赖安装
RUN pip3 install --no-cache-dir \
    requests \
    pyquery \
    pillow \
    beautifulsoup4 \
    cloudscraper \
    lxml \
    chardet \
    baidu-aip

# 创建应用数据目录
RUN mkdir /AVDC && mkdir /config
# 复制应用文件
COPY ./AVDC /AVDC
RUN chmod -R 2777 /config /AVDC

# 启动脚本配置
COPY startapp.sh /startapp.sh
RUN chmod +x /startapp.sh

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/media"]

