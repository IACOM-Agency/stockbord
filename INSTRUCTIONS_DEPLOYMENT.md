# 🚀 Instructions de Déploiement Automatique

## Option 1: Upload Direct (RECOMMANDÉ - 2 minutes)

1. **Téléchargez le fichier `stockbord_github_pages.zip`** qui vient d'être créé
2. **Allez sur votre repository GitHub**: https://github.com/IACOM-Agency/stockbord
3. **Cliquez sur "Add file" > "Upload files"**
4. **Glissez-déposez le fichier ZIP** ou cliquez pour le sélectionner
5. **Écrivez un message de commit** (ex: "Deploy StockBord application")
6. **Cliquez sur "Commit changes"**
7. **Allez dans Settings > Pages**
8. **Sélectionnez "Deploy from a branch" > "main" > "/ (root)"**
9. **Cliquez "Save"**

✅ **Votre site sera disponible à**: https://iacom-agency.github.io/stockbord/

## Option 2: Drag & Drop Individual (3 minutes)

Si le ZIP ne fonctionne pas:
1. Allez sur https://github.com/IACOM-Agency/stockbord
2. Glissez-déposez directement ces fichiers:
   - `index.html`
   - `.nojekyll`
   - `README.md` (remplacera l'existant)
3. Suivez les étapes 7-9 ci-dessus

## ⚡ Fonctionnalités Incluses

- ✅ **Stockage local** (localStorage + IndexedDB)
- ✅ **Support photos** avec compression automatique
- ✅ **Interface responsive** 
- ✅ **Lightbox pour photos**
- ✅ **Import/Export CSV**
- ✅ **Configuration Cloud Supabase** (optionnelle)
- ✅ **Sauvegarde automatique**

## 🔧 Configuration Cloud (Optionnelle)

Pour un stockage illimité multi-appareils:
1. Créez un compte gratuit sur https://supabase.com
2. Créez un nouveau projet
3. Allez dans Storage > Create bucket > "photos" (public)
4. Copiez l'URL et la clé API dans l'app
5. Cliquez "Migrer vers le Cloud"

---
**Temps total de déploiement: 2-3 minutes maximum** 🎉