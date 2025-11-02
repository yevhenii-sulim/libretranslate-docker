FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential wget curl pkg-config libsox-dev ffmpeg ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir libretranslate==1.3.11 gunicorn

ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0
ENV LT_DISABLE_FILES=true
ENV PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.app:create_app()"]
