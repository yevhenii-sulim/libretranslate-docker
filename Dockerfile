FROM libretranslate/libretranslate:latest

RUN pip install --no-cache-dir gunicorn

EXPOSE 8080

ENV LT_HOST=0.0.0.0
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0

ENTRYPOINT []

CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:${PORT:-8080} 'wsgi:app'"]
