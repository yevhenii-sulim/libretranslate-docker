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


FROM libretranslate/libretranslate:latest

# Встановлюємо gunicorn (іноді потрібен окремо)
RUN pip install --no-cache-dir gunicorn

# Попередньо завантажуємо лише потрібні моделі
RUN libretranslate --update-models --load-only en,uk || true

# Експортуємо порт
EXPOSE 5000

# Налаштування середовища
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0
ENV LT_DISABLE_FILES=true

# Запуск через gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.wsgi:app"]
