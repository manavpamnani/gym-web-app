FROM python:3.10

WORKDIR /app

COPY . /app

# Install flask
RUN pip install flask

EXPOSE  5000

# Run the Flask app
CMD ["python", "app.py"]
