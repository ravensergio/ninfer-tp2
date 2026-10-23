@echo off
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
rem Disk cache: saved conversations go to the named volume ninfer-kvcache-swift (cap 30 GiB); after a restart the server resumes from it instead of re-prefilling.
docker rm -f ninfer-Swift-Uncens
docker run --name ninfer-Swift-Uncens --gpus all -p 8090:8090 -v ninfer-models:/workspace/models -v ninfer-kvcache-swift:/workspace/kvcache ninfer-tp2 ^
  ninfer-serve /workspace/models/qwen3_8_27b_swift15abl_nvfp4full-dflash2.ninfer ^
  --model-id swift-1.5-qwen3.8-27b ^
  --chat-template /workspace/models/froggeric-chat_template-22_5.jinja ^
  --host 0.0.0.0 --port 8090 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 262144 --kv-capacity 262144 --device-state-slots 12 --max-private-continuations 12 --max-concurrency 4 ^
  --spec mtp --draft-tokens 3 --lm-head-draft ^
  --vision --vision-device 1 --max-vision-tokens 4096 ^
  --prefill-chunk 2048 ^
  --preserve-thinking --temperature 0.9 --top-p 0.95 --top-k 20 --min-p 0 ^
  --disk-cache-dir /workspace/kvcache --disk-cache-gib 30 ^
  --embedding-host