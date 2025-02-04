# Gunakan image dasar Python
FROM python:3.9-slim

# Set working directory di dalam container
WORKDIR /app

# Install dependencies yang diperlukan untuk spaCy dan en_core_web_md
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# Install numpy terlebih dahulu untuk memastikan versi yang benar
RUN pip install --no-cache-dir numpy==1.23.5

# Salin file requirements.txt ke dalam container
COPY requirements.txt .

# Install dependensi dari requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Salin seluruh kode aplikasi ke dalam container
COPY . .

# Download spaCy model
RUN python -m spacy download en_core_web_md

# Expose port untuk Flask
EXPOSE 5000

# Tentukan perintah untuk menjalankan aplikasi menggunakan Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]