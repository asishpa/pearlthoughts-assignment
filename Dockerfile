# Use Node.js as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY medusa-store/package*.json ./

# Install Medusa CLI globally and dependencies
RUN npm install -g @medusajs/medusa-cli && npm install

# Copy the rest of the application code
COPY medusa-store/. .

# Expose the Medusa server port
EXPOSE 7001



# Build the application (if needed)
RUN npm run build

# Command to start the Medusa server
CMD ["medusa", "start"]