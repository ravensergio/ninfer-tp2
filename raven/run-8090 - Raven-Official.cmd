@echo off
rem Ninfer TP2 - 180k ctx, host port 8090 (8080 is taken by searxng)
rem Container listens on 8080 internally; --host 0.0.0.0 makes the Docker mapping work.
docker rm -f ninfer-Qwen3.8-Raven
docker run --name ninfer-Qwen3.8-Raven --gpus all -p 8090:8090 -v ninfer-models:/workspace/models ninfer-tp2 ^
  ninfer-serve /workspace/models/qwen3_8_27b_nvfp4full-huihui-rraven-fp8attn.ninfer ^
  --chat-template /workspace/models/froggeric-chat_template-22_5.jinja ^
  --model-id qwen3.8-27b-nvfp4-rraven ^
  --host 0.0.0.0 --port 8090 ^
  --tp 2 --devices 0,1 --kv-dtype int8 ^
  --max-context 262144 --kv-capacity 262144 --device-state-slots 10 --max-private-continuations 10 --max-concurrency 3 ^
  --spec mtp --draft-tokens 3 --lm-head-draft ^
  --vision --vision-device 1 --max-vision-tokens 4096 ^
  --prefill-chunk 4096 ^
  --preserve-thinking --temperature 0.6 --top-p 0.95 --top-k 20 --min-p 0 ^
  --embedding-host