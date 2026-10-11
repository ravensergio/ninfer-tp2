@echo off
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
rem Model now from Docker volume (native ext4 read, no 9p)
docker rm -f ninfer-Qwen3.8-Quasar
docker run --name ninfer-Qwen3.8-Quasar --gpus all -p 8090:8090 -v ninfer-models:/workspace/models ninfer-tp2 ^
  ninfer-serve /workspace/models/qwen3_8_27b_quasar_nvfp4.ninfer ^
  --chat-template /workspace/models/froggeric-chat_template-22_5.jinja ^
  --host 0.0.0.0 --port 8090 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 262144 --kv-capacity 262144 --device-state-slots 14 --max-private-continuations 14 --max-concurrency 4 ^
  --spec mtp --draft-tokens 3 --lm-head-draft ^
  --vision --vision-device 1 --max-vision-tokens 4096 ^
  --preserve-thinking ^
  --embedding-host