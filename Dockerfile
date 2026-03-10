# Base image
FROM python:3.11-slim

# Set workdir
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code and tests
COPY app/ ./app
COPY tests/ ./tests

# Run tests by default
CMD ["python", "-m", "pytest", "-v"]
