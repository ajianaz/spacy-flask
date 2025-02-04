from flask import Flask, request, jsonify
import spacy

# Load the spaCy model
nlp = spacy.load("en_core_web_md")

# Initialize Flask app
app = Flask(__name__)

@app.route('/get_embedding', methods=['POST'])
def get_embedding():
    # Ambil teks dari request JSON
    data = request.get_json()
    text = data.get('text', '')

    # Proses teks dan ambil embedding
    doc = nlp(text)
    embedding = doc.vector.tolist()

    return jsonify({"embedding": embedding})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)