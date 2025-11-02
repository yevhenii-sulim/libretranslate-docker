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

FROM python:3.9-slim

# Системні залежності
RUN apt-get update && apt-get install -y --no-install-recommends \
    git g++ make wget pkg-config libsox-dev ffmpeg ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Встановлюємо pip і залежності
RUN pip install --no-cache-dir -U pip setuptools wheel

# Встановлюємо libretranslate та gunicorn
RUN pip install --no-cache-dir libretranslate==1.3.11 gunicorn

# Завантажуємо лише потрібні моделі
RUN libretranslate --update-models --load-only en,uk || true

# Експортуємо порт і середовище
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0
ENV LT_DISABLE_FILES=true

EXPOSE 5000

# Запуск через gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.app:create_app()"]
