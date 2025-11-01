FROM libretranslate/libretranslate:latest

EXPOSE 8080

ENV LT_HOST=0.0.0.0
ENV LT_PORT=8080
ENV LT_LOAD_ONLY=en,uk
ENV LT_REQ_LIMIT=0

CMD ["libretranslate", "--host", "0.0.0.0", "--port", "8080", "--load-only", "en,uk", "--req-limit", "0"]
