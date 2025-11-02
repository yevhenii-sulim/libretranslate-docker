FROM libretranslate/libretranslate:latest
RUN pip install --no-cache-dir gunicorn

EXPOSE 5000

ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0
ENV LT_DISABLE_FILES=true

ENV PATH="$PATH:/home/libretranslate/.local/bin"
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "libretranslate.wsgi:app"]
