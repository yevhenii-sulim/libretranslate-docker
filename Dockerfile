FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    git g++ make wget pkg-config libsox-dev ffmpeg && \
    pip install libretranslate==1.3.11 gunicorn && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8080

# Gunicorn запускає Flask-додаток через головну функцію
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "libretranslate.app:create_app()"]
