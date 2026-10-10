@echo off
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
docker rm -f ninfer-Swift-Orca
docker run --name ninfer-Swift-Orca --gpus all -p 8090:8090 -v ninfer-models:/workspace/models ninfer-tp2 ^
  ninfer-serve /workspace/models/swift-1.5-qwen3.8-27b-orcarouter-dflash2-nvfp4.ninfer ^
  --host 0.0.0.0 --port 8090 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 242144 --kv-capacity 242144 --device-state-slots 12 --max-private-continuations 12 --max-concurrency 3 ^
  --spec mtp --draft-tokens 3 --lm-head-draft ^
  --vision --vision-device 1 --max-vision-tokens 4096 ^
  --preserve-thinking ^
  --embedding-host