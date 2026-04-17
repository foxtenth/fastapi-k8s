# Use an official lightweight Python image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file first (this helps with Docker caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port FastAPI runs on
EXPOSE 8000

# Command to run the application
# We use 0.0.0.0 to allow the container to accept external traffic
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
