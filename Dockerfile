# Stage 1: Build
FROM node:lts-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the entire application code
COPY . .

# Build the Next.js app
RUN npm run build

# Stage 2: Run
FROM node:lts-alpine

# Set working directory
WORKDIR /app

# Install only production dependencies
COPY package.json package-lock.json ./
RUN npm install --omit=dev

# Copy the built application from the builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# Expose port and start the production server
EXPOSE 3000
CMD ["npm", "start"]
