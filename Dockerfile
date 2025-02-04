# Gunakan image dasar Python
FROM python:3.9-slim

# Set working directory di dalam container
WORKDIR /app

# Salin file requirements.txt ke dalam container
COPY requirements.txt .

# Install dependensi dari requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install spaCy
RUN pip install --no-cache-dir spacy

# Download spaCy model
RUN python -m spacy download en_core_web_md

# Salin seluruh kode aplikasi ke dalam container
COPY . .

# Expose port untuk Flask
EXPOSE 5000

# Tentukan perintah untuk menjalankan aplikasi menggunakan Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]