# Rapport de livraison — GIMMOBLIER2026

Date : 27 juin 2026

## Références

- Chemin local : `C:\optizaworks\GESTIONIMOBILIER V2026`
- Dépôt source : https://github.com/yassinait2007/immobilier.git
- Commit source cloné : `375bca464f505e628d00ae6e20e7a73629748279`
- Nouveau dépôt : https://github.com/YAZNAG/GIMMOBLIER2026.git
- Branche : `main`
- Commit d'import initial : `d2fb971`
- Base locale : `gestion_immobilier_2026`
- Dump versionné : `database/immobilier_app.sql`

## Opérations principales

1. Vérification de Git, PHP, Composer, Node.js, npm, MySQL et VS Code.
2. Clonage du dépôt source dans le dossier demandé.
3. Import du dump joint dans la base locale `gestion_immobilier_2026`.
4. Génération d'un dump public assaini : schéma complet de 50 tables et données
   de référence uniquement.
5. Ajout du README racine, du `.gitignore` et de `.env.example`.
6. Suppression des identifiants de démonstration présents dans les seeders.
7. Installation avec `composer install` et `npm ci`.
8. Build frontend avec `npm run build`.
9. Tests avec `php artisan test`.
10. Suppression de l'ancien historique Git, initialisation de `main`, commit et
    push vers le nouveau dépôt.

## Résultat du test local

- Projet lancé : Oui
- URL : http://127.0.0.1:8000/
- Réponse HTTP : `200 OK`
- Build Vite : réussi, 3 760 modules transformés
- Tests Laravel : 2 tests réussis, 2 assertions
- Migrations : toutes les migrations du dump sont reconnues comme exécutées

Le premier passage des tests a échoué car le manifeste Vite n'avait pas encore
été généré. Après `npm run build`, les tests ont tous réussi.

## Sécurité et limites connues

- Le `.env` local n'est pas versionné ; seul `.env.example` sans secret est inclus.
- Le dump original contient des comptes, des sessions, des jetons, des e-mails et
  des hashes de mots de passe. Il reste hors du dépôt public.
- Le dump versionné ne contient ni compte utilisateur, ni session, ni jeton, ni
  adresse e-mail, ni hash de mot de passe.
- Les comptes administrateur et agence codés en dur ont été retirés des seeders.
- `npm ci` signale 15 vulnérabilités de dépendances : 1 faible, 4 modérées,
  8 élevées et 2 critiques. Aucun `npm audit fix` automatique n'a été appliqué
  afin d'éviter une mise à niveau potentiellement cassante sans validation métier.
- Le dépôt source contient un pointeur de sous-module `immobilier-mobile` sans
  `.gitmodules`, sans URL et sans objet récupérable. Le code mobile n'a donc pas pu
  être restauré ; `immobilier-mobile/README.md` documente cette limitation.

## Confirmation finale

- Projet poussé sur GitHub : Oui
- Branche utilisée : `main`
- Code principal Laravel/React poussé : Oui
- Dump SQL public assaini poussé : Oui
- Fichiers sensibles exclus : Oui
- Historique Git source retiré : Oui
