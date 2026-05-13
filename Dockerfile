FROM node:20-slim

RUN apt-get update && apt-get install -y poppler-utils python3 python3-pip curl && rm -rf /var/lib/apt/lists/*
RUN pip3 install pypdf --break-system-packages

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

RUN mkdir -p templates && \
    curl -L -o templates/deed-template.docx https://github.com/opsNesevich/deeds_v3/releases/download/v.1.0/deed-template.docx && \
    curl -L -o templates/affidavit-template.pdf https://github.com/opsNesevich/deeds_v3/releases/download/v.1.0/affidavit-template.pdf && \
    curl -L -o templates/residency-template.pdf https://github.com/opsNesevich/deeds_v3/releases/download/v.1.0/residency-template.pdf

EXPOSE 8080
CMD ["npm", "start"]
