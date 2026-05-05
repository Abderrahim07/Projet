# ─── Stage 1 : Build ───────────────────────────────────────────────────────
FROM public.ecr.aws/docker/library/node:18-alpine AS builder

WORKDIR /app

COPY pipeline_animation_v2.html .

RUN npm install -g serve

# ─── Stage 2 : Runtime ─────────────────────────────────────────────────────
FROM public.ecr.aws/docker/library/node:18-alpine AS runtime

WORKDIR /app

COPY --from=builder /app/pipeline_animation_v2.html ./index.html

RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", ".", "-l", "3000"]
