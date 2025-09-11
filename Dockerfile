# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Remove the default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy your custom HTML file into the Nginx web directory
COPY index.html /usr/share/nginx/html/

# Expose port 8081
EXPOSE 8081

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
