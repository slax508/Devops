FROM node:18.9.0
# Create app directory
WORKDIR /usr/src/app
# Install app dependencies
COPY package*.json ./
RUN npm install
# Bundle app source
COPY . .
# Expose the port the app runs on
EXPOSE 5050
# Start the app
CMD ["npm", "start"]
# Use the following command to build the image
# docker build -t mern-backend .
