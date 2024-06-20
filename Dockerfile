FROM python:3.11-slim

WORKDIR /app

# 安装依赖项
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip && pip install -r requirements.txt

# 复制项目文件
COPY . .

# 设置容器启动命令
CMD ["python", "UI_pyqt.py"]
