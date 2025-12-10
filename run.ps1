docker run `
  -d `
  --net bridge `
  --pids-limit 2048 `
  -e TZ="America/Chicago" `
  -e HOST_OS="Windows" `
  -e HOST_HOSTNAME="${env:COMPUTERNAME}" `
  -e HOST_CONTAINERNAME="oromis995/sd-forge-neo" `
  -e NVIDIA_VISIBLE_DEVICES=all `
  -e COMMANDLINE_ARGS="--api --listen --cuda-malloc --xformers --skip-torch-cuda-test --enable-insecure-extension-access" `
  -p 7860:7860 `
  --gpus all `
  oromis995/sd-forge-neo
