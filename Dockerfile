FROM node:20-slim

WORKDIR /app

# Install required system libraries (fix for onnxruntime error)
RUN apt-get update && apt-get install -y \
    libc6 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project
COPY . .

# Build app
RUN npm run build

# Expose port
EXPOSE 3000

# Start app
CMD ["npm", "start"]
