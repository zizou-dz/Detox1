# AI Terminal - Application Android

Une application Flutter qui simule un terminal pour créer des fichiers et dossiers avec une interface style "terminal".

## 🚀 Fonctionnalités

- **Interface Terminal** : Design sombre avec texte vert style terminal
- **Création de fichiers** : Commande `create file <nom>` pour créer des fichiers
- **Création de dossiers** : Commande `create folder <nom>` pour créer des dossiers
- **Liste des fichiers** : Commande `list files` ou `ls` pour voir les fichiers créés
- **Historique** : Affichage de toutes les commandes exécutées
- **Commandes utiles** :
  - `help` : Afficher l'aide
  - `clear` : Effacer l'historique
  - `about` : À propos de l'application

## 📱 Commandes disponibles

```
> create file monfichier.txt    # Crée un fichier
> create folder mondossier      # Crée un dossier
> list files                    # Liste tous les fichiers
> ls                            # Alias pour list files
> clear                         # Efface le terminal
> help                          # Affiche l'aide
> about                         # Informations sur l'app
```

## 🔧 Configuration GitHub Actions

Le workflow est configuré pour générer automatiquement une APK lors des pushs sur `main`/`master`.

### Pour générer l'APK :

1. Poussez votre code vers GitHub
2. Allez dans l'onglet **Actions** de votre dépôt
3. Sélectionnez le workflow "Build AI Terminal APK"
4. Téléchargez l'APK depuis les artifacts

## 📦 Structure du projet

```
detox/
├── lib/
│   └── main.dart          # Code principal de l'application
├── android/               # Configuration Android
│   ├── app/
│   │   ├── build.gradle
│   │   └── src/main/
│   │       ├── AndroidManifest.xml
│   │       └── kotlin/com/aiterminal/app/MainActivity.kt
│   ├── build.gradle
│   └── settings.gradle
├── .github/
│   └── workflows/
│       └── build_apk.yml  # Workflow GitHub Actions
├── pubspec.yaml           # Dépendances Flutter
└── README.md
```

## 🛠️ Dependencies

- `flutter`: SDK Flutter
- `path_provider`: Gestion des chemins de fichiers
- `permission_handler`: Gestion des permissions Android

## 📄 License

MIT
