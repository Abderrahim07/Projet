# ─── Stage 1 : Build ───────────────────────────────────────────────────────
FROM node:18-alpine AS builder

WORKDIR /app

# Copier le fichier HTML
COPY pipeline_animation_v2.html .

# Installer un serveur HTTP léger
RUN npm install -g serve

# ─── Stage 2 : Runtime ─────────────────────────────────────────────────────
FROM node:18-alpine AS runtime

WORKDIR /app

# Copier depuis le stage build
COPY --from=builder /app/pipeline_animation_v2.html ./index.html

# Installer serve dans le runtime
RUN npm install -g serve

# Port exposé
EXPOSE 3000

# Lancer le serveur sur le fichier HTML
CMD ["serve", "-s", ".", "-l", "3000"]
