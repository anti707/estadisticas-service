FROM python:3.12-slim as base

WORKDIR /app
RUN groupadd -r appgroup && useradd -r -g appgroup -d /app -s /sbin/nologin appuser

RUN python -m pip install --no-cache-dir pip setuptools wheel
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=appuser:appgroup app app ./app

EXPOSE 8006

USER appuser

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8006"]
