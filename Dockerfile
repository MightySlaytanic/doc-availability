FROM python:3.13.0a6-alpine3.18 AS builder
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir --upgrade pip && pip3 install --user --no-cache-dir -r /tmp/requirements.txt

FROM python:3.13.0a6-alpine3.18
COPY --from=builder /root/.local /root/.local

WORKDIR /app
COPY main.py /app
ENV PATH=/root/.local:$PATH

ENTRYPOINT [ "python", "-u", "main.py" ]