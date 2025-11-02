FROM libretranslate/libretranslate:latest

# встановлюємо gunicorn
RUN pip install --no-cache-dir gunicorn

# Відкрити порт
EXPOSE 5000

# середовище
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0

# прибираємо стандартний entrypoint LibreTranslate
ENTRYPOINT []

# Запускаємо gunicorn без конфлікту з libretranslate
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.wsgi:app"]
