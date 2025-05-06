FROM node:18.17.0
# Create app directory
WORKDIR /usr/src/app
# Install app dependencies
COPY package*.json ./
RUN npm install
# Bundle app source
COPY . .
# Expose the port the app runs on
EXPOSE 5173
# Start the app
CMD ["npm", "run", "dev"]
# Use the following command to build the image
# docker build -t mern-frontend .
# Use the following command to run the container
# docker run -p 5173:5173 mern-frontend