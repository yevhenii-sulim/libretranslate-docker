FROM libretranslate/libretranslate:latest

# Встановлюємо gunicorn (продакшн WSGI сервер)
RUN pip install --no-cache-dir gunicorn

# Render задає свій порт через $PORT, тож відкриваємо стандартний 8080
EXPOSE 8080

# Налаштування LibreTranslate
ENV LT_HOST=0.0.0.0
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0

# Прибираємо стандартний entrypoint LibreTranslate
ENTRYPOINT []

# Запускаємо сервер через Gunicorn
CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:${PORT:-8080} 'wsgi:app'"]
