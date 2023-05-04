# BUILDER PHASE
FROM node:16-alpine as builder
# as builder - tagging the phase 'builder'

# /app/build after running npm run build
WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# RUN PHASE -
FROM nginx

# COPY BUILD FOLDER INSIDE NGINX
# copy /app/buiild from builder step and put in /usr/share/nginx/html so NGINX can serve the index.html
COPY --from=builder /app/build /usr/share/nginx/html

# NGINX by default will start it self