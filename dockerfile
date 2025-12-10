FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV PYTHON=/usr/bin/python3.11
ENV COMMANDLINE_ARGS=

#UUV Install for those who want it.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Create non-root user 'forge' with UID 99 and GID 100 (Unraid-compatible)
RUN useradd -u 99 -g 100 -d /home/forge forge

WORKDIR /home/forge

RUN apt-get update && apt-get install -y \
    python3.11 \
    git \
    ffmpeg \
    python3.11-venv \ 
    && rm -rf /var/lib/apt/lists/*


RUN git clone --branch neo https://github.com/Haoming02/sd-webui-forge-classic.git sd-webui

# Copy replacement script to allow docker to run a linux image rather than a Windows one
COPY webui.sh /home/forge/sd-webui/webui.sh

# Fix ownership
RUN chown -R forge:users /home/forge

WORKDIR /home/forge/sd-webui

USER forge

EXPOSE 7860

CMD ["./webui.sh"]
