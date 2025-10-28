# StockBord

Application web statique pour la gestion de stock et de devis avec photos.

Fonctionnalités principales:
- Catalogue d'articles avec vignettes photos
- Bibliothèque photos locale (IndexedDB), sélection multi-photos
- Recherche en temps réel
- Devis/Bordereau avec quantités, remises, TVA et impression
- Import/Export du catalogue en JSON et CSV
- Envoi POST vers un serveur externe (optionnel)

Déploiement GitHub Pages (gratuit, sans nom de domaine):
- Hébergement: `https://<votre-utilisateur>.github.io/stockbord/`
- Aucun achat requis; GitHub Pages est gratuit.

Étapes minimales:
1. Créez un nouveau dépôt GitHub nommé `stockbord` (public ou privé avec Pages activé).
2. Poussez le contenu du dossier `autobord_stock_web` à la racine du dépôt.
3. Activez GitHub Pages sur la branche `main` (Source: `Deploy from a branch`, Folder: `/root`).
4. Ajoutez le fichier `.nojekyll` (déjà fourni) pour servir correctement les assets.

Arborescence attendue du dépôt:
```
README.md
.nojekyll
index.html
```

Persistance des données:
- Articles et devis: `localStorage` (léger, immédiat)
- Photos: `IndexedDB` (capacité élevée, hors quotas `localStorage`)
- Export/Import: utilisez JSON/CSV pour sauvegarde/restauration externe

Remarques:
- La fonction "Envoyer au serveur" nécessite une API externe (non incluse).
- Les images stockées en IndexedDB restent locales à l'appareil. Pour synchroniser entre appareils, envisagez Supabase/Appwrite/PocketBase.