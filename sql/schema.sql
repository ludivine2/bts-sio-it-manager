CREATE DATABASE it_manager;

CREATE TABLE IF NOT EXISTS site (
    code_site VARCHAR(10) NOT NULL,
    nom_site VARCHAR(100) NOT NULL,
    ville VARCHAR(80) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    PRIMARY KEY (code_site)
);

CREATE TABLE IF NOT EXISTS service (
    code_service VARCHAR(10) NOT NULL,
    nom_service VARCHAR(100) NOT NULL,
    budget_annuel DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (code_service)
);

CREATE TABLE IF NOT EXISTS categorie (
    id_categorie INT NOT NULL AUTO_INCREMENT,
    libelle VARCHAR(50) NOT NULL,
    duree_amortissement_ans INT NOT NULL,
    PRIMARY KEY (id_categorie)
);

CREATE TABLE IF NOT EXISTS fournisseur (
    id_fournisseur INT NOT NULL AUTO_INCREMENT,
    raison_sociale VARCHAR(150) NOT NULL,
    contact_email VARCHAR(150) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    delai_livraison_jours INT NOT NULL,
    PRIMARY KEY (id_fournisseur)
);

CREATE TABLE IF NOT EXISTS logiciel (
    id_logiciel INT NOT NULL AUTO_INCREMENT,
    nom_logiciel VARCHAR(100) NOT NULL,
    editeur VARCHAR(100) NOT NULL,
    version VARCHAR(30) NOT NULL,
    type_licence VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_logiciel)
);

CREATE TABLE IF NOT EXISTS collaborateur (
    matricule VARCHAR(10) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email_pro VARCHAR(150) NOT NULL UNIQUE,
    tel_interne VARCHAR(20) NOT NULL,
    date_embauche DATE NOT NULL,
    code_service VARCHAR(10) NOT NULL,
    code_site VARCHAR(10) NOT NULL,
    PRIMARY KEY (matricule),
    FOREIGN KEY (code_service) REFERENCES service (code_service),
    FOREIGN KEY (code_site) REFERENCES site (code_site)
);

CREATE TABLE IF NOT EXISTS equipement (
    num_serie VARCHAR(50) NOT NULL,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(100) NOT NULL,
    date_achat DATE NOT NULL,
    prix_achat_ht DECIMAL(10,2) NOT NULL,
    date_fin_garantie DATE NOT NULL,
    etat VARCHAR(20) NOT NULL DEFAULT 'En stock',
    id_categorie INT NOT NULL,
    id_fournisseur INT NOT NULL,
    PRIMARY KEY (num_serie),
    FOREIGN KEY (id_categorie) REFERENCES categorie (id_categorie),
    FOREIGN KEY (id_fournisseur) REFERENCES fournisseur (id_fournisseur)
);

CREATE TABLE IF NOT EXISTS ticket (
    num_ticket INT NOT NULL AUTO_INCREMENT,
    date_ouverture DATE NOT NULL,
    description_panne TEXT NOT NULL,
    niveau_urgence VARCHAR(20) NOT NULL,
    statut VARCHAR(20) NOT NULL DEFAULT 'Ouvert',
    date_cloture DATE NULL DEFAULT NULL,
    num_serie VARCHAR(50) NOT NULL,
    matricule VARCHAR(10) NOT NULL,
    PRIMARY KEY (num_ticket),
    FOREIGN KEY (num_serie) REFERENCES equipement (num_serie),
    FOREIGN KEY (matricule) REFERENCES collaborateur (matricule)
);

CREATE TABLE IF NOT EXISTS affectation (
    num_serie VARCHAR(50) NOT NULL,
    matricule VARCHAR(10) NOT NULL,
    date_attribution DATE NOT NULL,
    date_restitution DATE NULL DEFAULT NULL,
    commentaire_etat VARCHAR(255) NULL,
    PRIMARY KEY (num_serie, matricule, date_attribution),
    FOREIGN KEY (num_serie) REFERENCES equipement (num_serie),
    FOREIGN KEY (matricule) REFERENCES collaborateur (matricule)
);

CREATE TABLE IF NOT EXISTS installation (
    num_serie VARCHAR(50) NOT NULL,
    id_logiciel INT NOT NULL,
    date_installation DATE NOT NULL,
    cle_licence VARCHAR(100) NOT NULL,
    PRIMARY KEY (num_serie, id_logiciel),
    FOREIGN KEY (num_serie) REFERENCES equipement (num_serie),
    FOREIGN KEY (id_logiciel) REFERENCES logiciel (id_logiciel)
);
