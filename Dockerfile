
FROM libretranslate/libretranslate:latest

# порт gunicorn
EXPOSE 5000

# середовище
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0

# встановити gunicorn (він не входить до базового образу)
RUN pip install --no-cache-dir gunicorn

# запуск через gunicorn як у доках
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.wsgi:app"]
