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

# syntax=docker/dockerfile:1
FROM python:3.10-slim

# Системні залежності (мінімальний набір для компіляції LTpycld2)
RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ make wget curl pkg-config libffi-dev libsox-dev ffmpeg ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Встановлюємо pip, setuptools, wheel
RUN pip install --no-cache-dir -U pip setuptools wheel

# Встановлюємо LibreTranslate (без зайвих фреймворків)
RUN CFLAGS="-Wno-narrowing" pip install --no-cache-dir libretranslate==1.3.11 gunicorn

# Завантажуємо лише потрібні моделі
RUN libretranslate --update-models --load-only en,uk || true

# Налаштування середовища
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0
ENV LT_DISABLE_FILES=true

EXPOSE 5000

# Запускаємо через gunicorn (WSGI)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.app:create_app()"]
