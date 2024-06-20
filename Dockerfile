# 使用官方 Python 镜像作为基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 复制 requirements.txt 文件并安装依赖项
COPY requirements.txt requirements.txt

# 安装CMake和其他依赖项
RUN apt-get update && apt-get install -y cmake && rm -rf /var/lib/apt/lists/*

# 安装 Python 依赖项
RUN pip install --upgrade pip && pip install -r requirements.txt

# 复制项目文件
COPY . .

# 指定运行命令
CMD ["python", "UI_pyqt.py"]
