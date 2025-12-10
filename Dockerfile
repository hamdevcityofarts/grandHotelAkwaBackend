# --- Étape 1: Build/Construction ---
FROM node:lts-alpine AS build

# Définir le répertoire de travail
WORKDIR /app

# ⚠️ CHANGEMENT ICI : Copier depuis le sous-dossier
COPY grand_hotel-backend/package*.json ./

# Installer les dépendances
RUN npm install --only=production

# ⚠️ CHANGEMENT ICI : Copier tout le sous-dossier
COPY grand_hotel-backend/ ./

# --- Étape 2: Production/Exécution ---
FROM node:lts-slim

WORKDIR /app

# Copier depuis l'étape de build
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app .

# Exposer le port (5001 pour akwa)
EXPOSE 5001

# Commande de démarrage
CMD ["npm", "start"]