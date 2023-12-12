FROM python:3.12

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
                postgresql-client \
        && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
COPY . /app/

EXPOSE 8000

RUN python3 manage.py makemigrations \
        && python3 manage.py migrate
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
