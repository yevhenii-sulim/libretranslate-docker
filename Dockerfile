FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    git g++ make wget pkg-config libsox-dev ffmpeg && \
    pip install --upgrade pip setuptools wheel && \
    pip install LTpycld2==0.2.10 libretranslate==1.3.11 gunicorn && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 5000

ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.wsgi:app"]
