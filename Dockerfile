FROM python:3.12-slim

# システムに必要なパッケージ（FFmpegなど）をインストール
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 依存関係のインストール
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# アプリケーションのコードをコピー
COPY . .

# Renderが割り当てるポート番号（$PORT）を使ってGunicornで起動
CMD gunicorn --bind 0.0.0.0:$PORT app:app