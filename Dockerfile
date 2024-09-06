# Use Node.js as the base image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json into the container
COPY package*.json ./

# Install Medusa CLI globally and dependencies
RUN npm install -g @medusajs/medusa-cli && npm install

# Copy the rest of the application code
COPY . .

# Expose the Medusa server port
EXPOSE 7001

# Set environment variables (replace these values with actual secrets in production)
ENV DATABASE_URL="postgresql://medusa-db_owner:oOQz0jc9XnqC@ep-holy-salad-a5nn97r0-pooler.us-east-2.aws.neon.tech/medusa-db?sslmode=require"


# Build the application (if needed)
RUN npm run build

# Command to start the Medusa server
CMD ["medusa", "start"]