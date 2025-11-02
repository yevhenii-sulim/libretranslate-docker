# FROM libretranslate/libretranslate:latest
# RUN pip install --no-cache-dir gunicorn

# EXPOSE 5000

# ENV LT_HOST=0.0.0.0
# ENV LT_PORT=5000
# ENV LT_LOAD_ONLY=en,uk
# ENV LT_REQ_LIMIT=0
# ENV LT_DISABLE_FILES=true

# ENV PATH="$PATH:/home/libretranslate/.local/bin"
# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.wsgi:app"]

FROM python:3.10-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl ffmpeg ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -U pip setuptools wheel

# Завантажуємо LTpycld2 уже зібраний з PyPI (без компіляції)
RUN pip install --no-cache-dir LTpycld2==0.1.0.post2
RUN pip install --no-cache-dir libretranslate==1.3.11 gunicorn

RUN libretranslate --update-models --load-only en,uk || true

ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0
ENV LT_DISABLE_FILES=true

EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.app:create_app()"]
