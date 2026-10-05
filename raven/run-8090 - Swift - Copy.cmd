@echo on
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
docker run --name ninfer-Swift-OrcaDF --gpus all -p 8090:8080 -v E:\z_Working_PI\00-NinferTP2\models:/workspace/models ninfer-tp2 ^
  ninfer-serve /workspace/models/swift-1.5-qwen3.8-27b-orcarouter-dflash2-nvfp4.ninfer ^
  --host 0.0.0.0 --port 8080 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 120000 --kv-capacity 120000 --device-state-slots 4 --max-concurrency 3 ^
  --spec dflash2 --lm-head-draft --draft-tokens 7 --vision --vision-device 0 --max-vision-tokens 4096 ^
  --preserve-thinking