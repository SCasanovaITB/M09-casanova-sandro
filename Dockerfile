FROM ubuntu:24.04

# Actualitzar i instal·lar paquets necessaris
RUN apt update && apt install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    novnc \
    websockify \
    openssh-server \
    wget \
    python3 \
    python3-pip \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/*
RUN apt update && apt install -y dbus-x11
RUN apt update && apt install -y nano

# Crear l'usuari 'developer' per treballar en l'entorn gràfic
RUN useradd -m -s /bin/bash developer && echo "developer:developerpassword" | chpasswd
USER developer
WORKDIR /home/developer

# Configurar VNC per 'developer'
RUN mkdir -p /home/developer/.vnc && \
    echo "developerpassword" | vncpasswd -f > /home/developer/.vnc/passwd && \
    chmod 600 /home/developer/.vnc/passwd

# Instal·lar Visual Studio Code com a root però accessible per 'developer'
USER root
RUN wget -qO /tmp/vscode.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable && \
    apt install -y /tmp/vscode.deb && \
    rm /tmp/vscode.deb

# Assegurar que 'developer' pugui executar el servidor VNC
USER developer
RUN echo "startxfce4 &" > /home/developer/.vnc/xstartup && \
    chmod +x /home/developer/.vnc/xstartup

# Exposar ports per VNC i SSH
EXPOSE 5901 6080 2222

# Script d'inici per l'usuari developer
CMD ["/bin/bash", "-c", "vncserver :1 -geometry 1280x800 -depth 24 && tail -f /dev/null"]
