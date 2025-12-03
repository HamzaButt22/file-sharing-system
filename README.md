# 🐳 *Docker File Sharing System with Volume Persistence*

A robust file sharing system demonstrating persistent storage using Docker volumes between host and container. This project showcases how Docker volumes maintain data persistence across container lifecycles.

## 🎯 *Project Overview*

This system provides an interactive menu-based interface for sharing files and folders between a Docker container and the host system, using Docker volumes for persistent storage. The project demonstrates key Docker concepts including containerization, volume mounting, and data persistence.

### *Key Features Demonstrated*
- ✅ *Docker Volume Persistence* - Data survives container restarts
- ✅ *Interactive Menu System* - User-friendly command-line interface
- ✅ *File & Folder Operations* - Send, receive, and manage files
- ✅ *Cross-Platform Compatibility* - Works on any system with Docker
- ✅ *Automated Volume Management* - Docker handles storage automatically

## 🏗 *System Architecture*


Host Machine (Debian VM) ←→ Docker Container ←→ Docker Volumes
        ↓                         ↓                         ↓
    Debian OS              File Sharing System        Persistent Storage
                          (Interactive Menu)        (file_share_data,
                                                    incoming_data, 
                                                    logs_data)


## 📊 *Performance Benefits*

### *Traditional File Sharing vs Docker Volume Approach*

| Aspect | Traditional Approach | Docker Volumes |
|--------|---------------------|----------------|
| *Persistence* | Manual backup required | Automatic persistence |
| *Portability* | Platform-dependent | Cross-platform |
| *Isolation* | Direct host access | Containerized isolation |
| *Setup* | Complex configuration | Simple Docker commands |
| *Scalability* | Limited | Easily scalable |

### *Key Advantages*
- *🔒 Data Safety*: Files persist even if container crashes or is deleted
- *⚡ Performance*: Direct volume access without network overhead
- *🔧 Simplicity*: No complex shared folder configurations needed
- *📦 Portability*: Works on any system with Docker installed
- *🔄 Version Control*: Entire system can be version-controlled via GitHub

## 🛠 *Technology Stack*

- *Docker* - Containerization platform
- *Docker Compose* - Container orchestration
- *Debian Linux* - Base operating system
- *Bash Scripting* - Interactive menu system
- *Docker Volumes* - Persistent storage mechanism

## 📋 *Prerequisites*

Before installation, ensure you have:

- *Docker Engine* (version 20.10.0 or higher)
- *Docker Compose* (version 2.0.0 or higher)
- *Linux environment* (tested on Debian 13)

### *Install Prerequisites on Debian*

bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
sudo apt install docker.io -y

# Install Docker Compose
sudo apt install docker-compose -y

# Add user to docker group (avoid sudo for docker commands)
sudo usermod -aG docker $USER
newgrp docker

# Verify installation
docker --version
docker-compose --version


## 🚀 *Installation & Setup*

### *Method 1: Clone from GitHub (Recommended)*

bash
# Clone the repository
git clone https://github.com/HamzaButt22/file-sharing-system.git
cd file-sharing-system

# Make scripts executable
chmod +x scripts/*

# Build and start the system
docker-compose build
docker-compose up -d


### *Method 2: Manual Setup*

bash
# Create project directory
mkdir file-sharing-system
cd file-sharing-system

# Create scripts directory
mkdir scripts

# Copy all script files to scripts/ directory
# Copy Dockerfile and docker-compose.yml to root directory

# Set permissions and build
chmod +x scripts/*
docker-compose build
docker-compose up -d


## 🎮 *How to Use*

### *Starting the System*

bash
# Navigate to project directory
cd file-sharing-system

# Start the container
docker-compose up -d

# Access the interactive menu
docker exec -it file-sharing-container /app/combined_menu


### *Menu Options*


===== DOCKER FILE SHARING SYSTEM =====
1) Send a File
2) Send a Folder
3) Receive a File
4) Receive a Folder
5) Delete Sent Item
6) View Docker Volumes
7) Exit


### *Usage Examples*

#### *Sending a File*
1. Choose *Option 1* from menu
2. Enter file path: /etc/hosts or ~/Documents/test.txt
3. File is copied to Docker volume and persists across restarts

#### *Receiving a File*
1. Choose *Option 3* from menu
2. Select from available files in shared volume
3. File is copied to incoming volume

#### *Checking Volume Contents*
1. Choose *Option 6* from menu
2. View all files in Docker volumes
3. Verify persistence after container restart

## 🧪 *Testing Persistence (Key Feature)*

### *Complete Persistence Test*

bash
# 1. Start the system
docker-compose up -d

# 2. Send a test file through the menu
docker exec -it file-sharing-container /app/combined_menu
# Choose Option 1 → Enter /etc/hosts

# 3. Stop the container
docker-compose down

# 4. Verify volume persists
docker volume ls
# Should show: file_sharing_system_file_share_data

# 5. Restart container
docker-compose up -d

# 6. Verify file still exists
docker exec -it file-sharing-container /app/combined_menu
# Choose Option 6 - the file should still be there!


### *Advanced Testing*

bash
# Test multiple container restarts
for i in {1..5}; do
    echo "Test iteration $i"
    docker-compose down
    docker-compose up -d
    docker exec -it file-sharing-container ls -la /shared_volume
    sleep 2
done


## 📁 *Project Structure*


file-sharing-system/
├── Dockerfile                 # Container definition
├── docker-compose.yml         # Orchestration configuration
├── scripts/                   # Bash script files
│   ├── combined_menu         # Main interactive menu
│   ├── sendfile              # File sending functionality
│   ├── sendfolder            # Folder sending functionality
│   ├── receivefile           # File receiving functionality
│   └── receivefolder         # Folder receiving functionality
├── README.md                  # This documentation
└── .gitignore                 # Git ignore rules


### *Volume Structure in Container*

/shared_volume     # Files available for sharing
/incoming_volume   # Received files storage
/logs_volume       # Operation logs and history


## 🔧 *Troubleshooting*

### *Common Issues and Solutions*

#### *Container Fails to Start*
bash
# Check Docker logs
docker-compose logs

# Rebuild from scratch
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d


#### *Permission Errors*
bash
# Add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# Fix file permissions
chmod +x scripts/*


#### *Volume Access Issues*
bash
# Check volume status
docker volume ls
docker volume inspect file_sharing_system_file_share_data

# Manual volume access
sudo ls -la /var/lib/docker/volumes/file_sharing_system_file_share_data/_data


### *Debugging Commands*

bash
# Check container status
docker ps
docker stats

# Check volume contents
docker exec -it file-sharing-container ls -la /shared_volume

# View system logs
docker logs file-sharing-container


## 📊 *Performance Metrics*

### *File Operations Performance*
- *File Transfer Speed*: Limited only by disk I/O
- *Concurrent Operations*: Supports multiple simultaneous operations
- *Volume Scalability*: Volumes automatically scale with storage needs

### *Resource Usage*
- *Memory Usage*: ~50MB (minimal overhead)
- *CPU Usage*: Negligible during idle state
- *Storage Efficiency*: Only stores actual file data

## 🚀 *Advanced Usage*

### *Custom Volume Mounts*
Modify docker-compose.yml for custom volume paths:

yaml
services:
  file-sharing-app:
    # ... existing config ...
    volumes:
      - /custom/host/path:/shared_volume  # Custom host path
      - incoming_data:/incoming_volume
      - logs_data:/logs_volume


### *Multiple Instances*
bash
# Scale to multiple instances (for testing)
docker-compose up -d --scale file-sharing-app=3


### *Backup and Restore*
bash
# Backup volume data
docker run --rm -v file_sharing_system_file_share_data:/volume -v $(pwd):/backup alpine \
    tar czf /backup/backup.tar.gz -C /volume ./

# Restore volume data
docker run --rm -v file_sharing_system_file_share_data:/volume -v $(pwd):/backup alpine \
    sh -c "rm -rf /volume/* && tar xzf /backup/backup.tar.gz -C /volume"


## 🤝 *Contributing*

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch: git checkout -b feature/amazing-feature
3. Commit changes: git commit -m 'Add amazing feature'
4. Push to branch: git push origin feature/amazing-feature
5. Open a Pull Request

### *Development Setup*
bash
# Clone and setup development environment
git clone https://github.com/HamzaButt22/file-sharing-system.git
cd file-sharing-system

# Create development branch
git checkout -b development

# Make changes and test
docker-compose up -d
docker exec -it file-sharing-container /app/combined_menu


## 📝 *License*

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 *Acknowledgments*

- Docker Inc. for the excellent containerization platform
- Debian Project for the stable Linux distribution
- The open-source community for continuous inspiration

## 📞 *Support*

If you encounter any issues or have questions:

1. Check the [Troubleshooting](#troubleshooting) section
2. Search existing [Issues](https://github.com/HamzaButt22/file-sharing-system/issues)
3. Create a new issue with detailed description

---

## 🎯 *Project Demonstration Guide*

### *Quick Demo Sequence*
bash
# 1. Clone and setup
git clone https://github.com/HamzaButt22/file-sharing-system.git
cd file-sharing-system
docker-compose up -d

# 2. Demonstrate functionality
docker exec -it file-sharing-container /app/combined_menu
# Show menu options and send a file

# 3. Demonstrate persistence
docker-compose down
docker-compose up -d
docker exec -it file-sharing-container /app/combined_menu
# Show file still exists after restart

# 4. Show Docker volumes
docker volume ls
docker volume inspect file_sharing_system_file_share_data


### *Key Points to Highlight*
- ✅ *Persistence*: Files survive container lifecycle
- ✅ *Isolation*: Containerized environment
- ✅ *Ease of Use*: Simple menu interface
- ✅ *Portability*: Works on any Docker-supported system

---

*Happy File Sharing!* 🎉
