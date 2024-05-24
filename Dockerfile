# Init a new build stage and set the base image for subsequent instructions.
FROM node:16-alpine
# Set the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it.
WORKDIR /my-app
# Copy files from a local source location to a destination.
COPY package*.json ./
# Execute any commands in a new layer on top of the current image and commit the results.
RUN npm install
COPY . .
# Expose a particular port inside a Docker container.
EXPOSE 8080
# There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last
# CMD will take effect. The main purpose of a CMD is to provide defaults for an executing container.
CMD ["node", "index.js"]
