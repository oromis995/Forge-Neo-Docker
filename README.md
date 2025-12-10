# SD-WebUI Forge Neo (Docker)

This repository provides a Docker setup for **SD-WebUI Forge Neo** by Haoming02, a branch of the Automatic1111 Stable Diffusion WebUI designed for advanced usage with GPU acceleration.

The container is configured for **Python 3.11**, NVIDIA GPU passthrough, and optional persistent volumes for models, outputs, logs, and extensions.

Files are included for Unraid configuration, but they are not necessary. 


https://github.com/Haoming02/sd-webui-forge-classic/tree/neo

> [!WARNING] If running Nvidia Drivers, ensure they are up to date.

---

## Features

- Fully containerized WebUI with **GPU support**.
- Pre-configured Python 3.11 virtual environment (`venv` created inside container).
- Optional persistent volumes for:
  - `/home/forge/sd-webui/outputs`
  - `/home/forge/sd-webui/models`
  - `/home/forge/sd-webui/log`
  - `/home/forge/sd-webui/extensions`
- No default host path mapping required — works out-of-the-box on Windows, Linux, and Unraid.
- Includes **UUV** (optional) for accelerated execution.
- Non-root user `forge` for safe container execution.

---

## Usage

### Build the container

```bash
docker build -t oromis995/sd-forge-neo .
```
