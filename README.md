# 📌 Docker VNC Setup
This repository provides instructions for building and running a Docker container with VNC support.
# 🚀 Steps
### 1️⃣ Build the image with docker build 
```bash
docker build -t vnc-ubuntu-scs .
```
### 2️⃣ Run a new container with docker run
```bash
docker run -dit -p 5901:5901 -p 5431:22 --name my-ubuntu-xfce vnc-ubuntu-scs bash
```
### 3️⃣ Execute commands inside the container
Use the following steps to configure and run the VNC server inside the container:
```bash
docker exec -it my-ubuntu-xfce bash
export USER=root
vncserver :1 -geometry 1280x800 -depth 24
```
### 4️⃣ Modify VNC startup script
If needed, you can edit the startup script for VNC:
```bash
nano ~/.vnc/xstartup
```
After editing, make sure it is executable:
```bash
chmod +x ~/.vnc/xstartup
```
### 5️⃣ Restart the VNC server with new settings
Stop the running VNC server:
```bash
vncserver -kill :1
```
Start it again with updated resolution:
```bash
vncserver :1 -geometry 1920x1080 -depth 24
```
### 6️⃣ Connect using a VNC client
Using Remmina (or any VNC client)
Connect to localhost:5901 (if running locally)
Default password: developerpassword · You can change this in the Dockerfile, but it's not recommended.
### 7️⃣ The public URL of Docker Hub


# 📋 Notes
Ensure you have Docker installed before running the commands.

Verify that the VNC port is properly configured in the container.

