FROM debian:12-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    bash \
    coreutils \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /app

# Copy scripts
COPY scripts/ ./

# Make scripts executable
RUN chmod +x *

# Create volume mount points
RUN mkdir -p /shared_volume /incoming_volume /logs_volume

# Set entry point (UPDATED to use .sh extension)
CMD ["./combined_menu"]
