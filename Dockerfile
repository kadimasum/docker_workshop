# FROM python:3.8.3-slim

# # Install build tools
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends build-essential && \
#     rm -rf /var/lib/apt/lists/*

# WORKDIR /app
# COPY requirements.txt requirements.txt
# RUN pip install -r requirements.txt
# COPY . .

# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# CMD ["python", "manage.py", "runserver","0.0.0.0:8000"]


# Use a smaller base image
FROM python:3.8.3-alpine

# Install build tools and dependencies
RUN apk add --no-cache build-base && \
    apk add --no-cache libffi-dev openssl-dev && \
    rm -rf /var/cache/apk/*

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]