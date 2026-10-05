@echo off
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
docker run --name ninfer-Qwen3.8-Quasar --gpus all -p 8090:8080 -v E:\z_Working_PI\00-NinferTP2\models:/workspace/models ninfer-tp2 ^
  ninfer-serve /workspace/models/qwen3_8_27b_quasar_nvfp4.ninfer ^
  --host 0.0.0.0 --port 8080 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 242144 --kv-capacity 242144 --device-state-slots 12 --max-private-continuations 12 --max-concurrency 3 ^
  --spec mtp --draft-tokens 3 --vision --vision-device 1 --max-vision-tokens 4096 ^
  --preserve-thinking ^
  --embedding-host