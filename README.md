# SD-WebUI Forge Neo (Docker)

This repository provides a Docker setup for **SD-WebUI Forge Neo** by Haoming02, a branch of the Automatic1111 Stable Diffusion WebUI designed for advanced usage with GPU acceleration.

The container is configured for **Python 3.11**, NVIDIA GPU passthrough, and optional persistent volumes for models, outputs, logs, and extensions.

Files are included for Unraid configuration, but they are not necessary. 


https://github.com/Haoming02/sd-webui-forge-classic/tree/neo

[!WARNING] If running Nvidia Drivers, ensure they are up to date.

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

### Run the container

```bash
docker run --gpus all \
  -d \
  --name sd-forge-neo \
  -e TZ="America/Chicago" \
  -e HOST_OS="Linux/Windows" \
  -e HOST_CONTAINERNAME="sd-forge-neo" \
  -p 7860:7860 \
  oromis995/sd-forge-neo
```

> ⚠ Optional volumes:
>
> To persist models, outputs, logs, or extensions on the host, add `-v` flags at runtime:
>
> ```bash
> -v /host/models:/home/forge/sd-webui/models \
> -v /host/outputs:/home/forge/sd-webui/outputs \
> -v /host/log:/home/forge/sd-webui/log \
> -v /host/extensions:/home/forge/sd-webui/extensions
> ```
>
> If not provided, Docker will create internal anonymous volumes automatically.

---

## Environment Variables

| Variable                 | Description                           | Default  |
| ------------------------ | ------------------------------------- | -------- |
| `TZ`                     | Timezone                              | `UTC`    |
| `HOST_OS`                | Host OS identifier                    | Optional |
| `HOST_CONTAINERNAME`     | Name of container on host             | Optional |
| `NVIDIA_VISIBLE_DEVICES` | GPU selection                         | `all`    |
| `COMMANDLINE_ARGS`       | Additional launch arguments for WebUI | Empty    |

---

## Ports

* `7860/tcp` — WebUI interface

---

## Notes

* **Do not declare the virtual environment (`venv`) as a volume** — it must remain internal to the container to avoid permission issues.
* The container user `forge` is **non-root** (UID 99, GID 100) for safer operation.