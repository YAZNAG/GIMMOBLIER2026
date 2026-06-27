# GIMMOBLIER2026

Projet de gestion immobilière — version 2026.

## Source initiale

Projet initial cloné depuis :
https://github.com/yassinait2007/immobilier.git

Nouveau dépôt :
https://github.com/YAZNAG/GIMMOBLIER2026.git

## Structure

- `immobilier-app/` : application Laravel 12, API PHP 8.2 et interface React 19/Vite.
- `database/immobilier_app.sql` : schéma complet et données de référence assainies.
- `immobilier-mobile/` : note concernant le sous-module mobile manquant dans le dépôt source.

Le dépôt source référence `immobilier-mobile` comme sous-module, mais ne fournit ni
`.gitmodules`, ni URL distante, ni contenu récupérable. Le dossier contient donc une
note de traçabilité et non le code mobile.

## Prérequis

- PHP 8.2 ou supérieur avec `pdo_mysql`
- Composer 2
- Node.js 20 ou supérieur et npm
- MySQL 8 ou MariaDB 10.4 ou supérieur

## Installation locale

1. Créer la base de données :

   ```sql
   CREATE DATABASE gestion_immobilier_2026
     CHARACTER SET utf8mb4
     COLLATE utf8mb4_unicode_ci;
   ```

2. Importer le dump public assaini :

   ```powershell
   mysql -u root -p gestion_immobilier_2026 < database\immobilier_app.sql
   ```

3. Installer et configurer l'application :

   ```powershell
   cd immobilier-app
   composer install
   npm ci
   Copy-Item .env.example .env
   php artisan key:generate
   php artisan storage:link
   ```

4. Adapter au minimum `DB_USERNAME` et `DB_PASSWORD` dans `.env`. Les variables
   Stripe, Google Maps, reCAPTCHA, Reverb et Wasender sont optionnelles pour un
   démarrage de base et doivent rester vides tant qu'aucune clé locale n'est fournie.

5. Pour créer un administrateur, renseigner localement `ADMIN_EMAIL` et un
   `ADMIN_PASSWORD` d'au moins 12 caractères, puis exécuter :

   ```powershell
   php artisan db:seed --class=AdminSeeder
   ```

   Aucun identifiant administrateur par défaut n'est stocké dans le dépôt.

6. Lancer l'API et le frontend dans deux terminaux :

   ```powershell
   # Terminal 1
   php artisan serve --host=127.0.0.1 --port=8000

   # Terminal 2
   npm run dev -- --host 127.0.0.1
   ```

7. Ouvrir l'URL affichée par Vite. L'API répond sur `http://127.0.0.1:8000`.

## Vérifications

```powershell
cd immobilier-app
php artisan test
npm run build
```

## Sécurité des données

Le dump joint d'origine a été importé uniquement dans la base locale. Il contient
des comptes, des sessions, des jetons et des données personnelles ; il n'est pas
publié. Le fichier versionné conserve le schéma complet et uniquement des données
de référence non personnelles.

