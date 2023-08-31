# 基础镜像
FROM amd64/python:3.10-slim
ENV OPENAI_API_KEY=a65f52d60c744eb9b141d9939cd4c4b6
ENV OPENAI_API_TYPE=azure
ENV OPENAI_API_BASE=https://openaidemo-hu.openai.azure.com/
ENV OPENAI_API_VERSION=2023-05-15
ENV AZURE_OPENAI_DEPLOYMENTS='[{"displayName": "GPT-4", "name": "gpt4"},{"displayName": "GPT-3.5", "name": "gpt-35-turbo"}]'
ENV OPENAI_API_LOGLEVEL=info
ENV API_PORT=5010
ENV WEB_PORT=8080
ENV SNAKEMQ_PORT=8765

# 安装依赖
RUN apt-get update && apt-get install -y gcc python3-dev

# 设置工作目录
WORKDIR /app

# 复制 main.py,kernel_connection_file.json和requirements.txt文件到容器中
COPY main.py .
COPY kernel_connection_file.json .
COPY requirements.txt .

# 复制 webapp,workspace和kernel_program目录到容器中
COPY webapp webapp/
COPY workspace workspace/
COPY kernel_program kernel_program/

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 暴露端口
EXPOSE 8080

# 启动应用
CMD ["python", "main.py"]