@echo off
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
docker rm -f ninfer-ThinkingCap
docker run --name ninfer-ThinkingCap --gpus all -p 8090:8090 -v ninfer-models:/workspace/models ninfer-tp2 ^
  ninfer-serve /workspace/models/qwen3_8_27b_thinkingcap_nvfp4full-dflash2.ninfer ^
  --model-id qwen3.8-27b-thinkingcap ^
  --chat-template /workspace/models/froggeric-chat_template-22_5.jinja ^
  --host 0.0.0.0 --port 8090 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 262144 --kv-capacity 262144 --device-state-slots 12 --max-private-continuations 12 --max-concurrency 3 ^
  --spec mtp --draft-tokens 3 --lm-head-draft ^
  --vision --vision-device 1 --max-vision-tokens 4096 ^
  --prefill-chunk 2048 ^
  --preserve-thinking --temperature 0.7 --top-p 0.95 --top-k 20 --min-p 0 ^
  --embedding-host