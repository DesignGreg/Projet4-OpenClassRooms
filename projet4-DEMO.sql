-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  ven. 30 nov. 2018 à 16:57
-- Version du serveur :  5.6.34-log
-- Version de PHP :  7.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `projet4`
--

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `num_client` int(11) NOT NULL,
  `prenom_client` varchar(45) NOT NULL,
  `nom_client` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`num_client`, `prenom_client`, `nom_client`) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Doe');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `num_commande` int(11) NOT NULL,
  `date_commande` timestamp(2) NOT NULL DEFAULT CURRENT_TIMESTAMP(2) ON UPDATE CURRENT_TIMESTAMP(2),
  `montant_commande` decimal(6,2) NOT NULL,
  `statut_commande` enum('en cours','livrée') NOT NULL,
  `num_client` int(11) NOT NULL,
  `num_livreur` int(11) NOT NULL,
  `Localisation_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`num_commande`, `date_commande`, `montant_commande`, `statut_commande`, `num_client`, `num_livreur`, `Localisation_id`) VALUES
(1, '2018-11-30 16:53:56.41', 16.00, 'livrée', 2, 1, 3),
(2, '2018-11-29 12:10:19.00', 18.00, 'livrée', 1, 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `livreur`
--

CREATE TABLE `livreur` (
  `num_livreur` int(11) NOT NULL,
  `nom_livreur` varchar(45) NOT NULL,
  `plats_en_stock` mediumtext NOT NULL,
  `statut` tinyint(1) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `livreur`
--

INSERT INTO `livreur` (`num_livreur`, `nom_livreur`, `plats_en_stock`, `statut`, `latitude`, `longitude`) VALUES
(1, 'Coyote', 'let plats = {\r\n   nomPlat:\r\n   quantite:\r\n};\r\n\r\nlet desserts = {\r\n   nomPlat:\r\n   quantite:\r\n};', 1, 48.5102, 2.19085),
(2, 'Jaguar', 'let plats = {\r\n   nomPlat:\r\n   quantite:\r\n};\r\n\r\nlet desserts = {\r\n   nomPlat:\r\n   quantite:\r\n};', 1, 48.5102, 2.19085);

-- --------------------------------------------------------

--
-- Structure de la table `localisation`
--

CREATE TABLE `localisation` (
  `id` int(11) NOT NULL,
  `voie` varchar(45) NOT NULL,
  `complement` varchar(45) DEFAULT NULL,
  `code_postal` varchar(5) NOT NULL,
  `ville` varchar(45) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `Client_num_client` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `localisation`
--

INSERT INTO `localisation` (`id`, `voie`, `complement`, `code_postal`, `ville`, `telephone`, `latitude`, `longitude`, `Client_num_client`) VALUES
(1, 'rue de Sèvres', 'Bat A', '75007', 'Paris', '0606060606', 48.5102, 2.19085, 1),
(2, 'rue de Sèvres', 'Bat A', '75007', 'Paris', '0707070707', 48.5102, 2.19085, 2),
(3, 'rue travail', 'Bureau 13', '75009', 'Paris', '0707070707', 48.5102, 2.19085, 2);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `num_produit` int(11) NOT NULL,
  `nom_produit` varchar(45) NOT NULL,
  `type_produit` enum('plat','dessert') NOT NULL,
  `ingredients` mediumtext NOT NULL,
  `prix` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`num_produit`, `nom_produit`, `type_produit`, `ingredients`, `prix`) VALUES
(1, 'Spaghettis sauce bolognaise', 'plat', '', 8.00),
(2, 'Sushi', 'plat', 'poisson', 9.00),
(3, 'Salade de fruit', 'dessert', 'banane, fraise, kiwi', 9.00),
(4, 'Fondant chocolat', 'dessert', '', 8.00);

-- --------------------------------------------------------

--
-- Structure de la table `produits_dans_commande`
--

CREATE TABLE `produits_dans_commande` (
  `id` int(11) NOT NULL,
  `Commande_num_commande` int(11) NOT NULL,
  `Produit_num_produit` int(11) NOT NULL,
  `quantite_produits` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `produits_dans_commande`
--

INSERT INTO `produits_dans_commande` (`id`, `Commande_num_commande`, `Produit_num_produit`, `quantite_produits`) VALUES
(1, 1, 1, 1),
(2, 1, 4, 1),
(3, 2, 2, 1),
(4, 2, 3, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`num_client`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`num_commande`),
  ADD KEY `fk_commande_Client_idx` (`num_client`),
  ADD KEY `fk_commande_Livreur1_idx` (`num_livreur`),
  ADD KEY `fk_Commande_Localisation1_idx` (`Localisation_id`);

--
-- Index pour la table `livreur`
--
ALTER TABLE `livreur`
  ADD PRIMARY KEY (`num_livreur`);

--
-- Index pour la table `localisation`
--
ALTER TABLE `localisation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Localisation_Client1_idx` (`Client_num_client`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`num_produit`);

--
-- Index pour la table `produits_dans_commande`
--
ALTER TABLE `produits_dans_commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Commande_has_Produit_Produit1_idx` (`Produit_num_produit`),
  ADD KEY `fk_Commande_has_Produit_Commande1_idx` (`Commande_num_commande`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `num_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `num_commande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `livreur`
--
ALTER TABLE `livreur`
  MODIFY `num_livreur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `localisation`
--
ALTER TABLE `localisation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `num_produit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `produits_dans_commande`
--
ALTER TABLE `produits_dans_commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_Commande_Localisation1` FOREIGN KEY (`Localisation_id`) REFERENCES `localisation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commande_Client` FOREIGN KEY (`num_client`) REFERENCES `client` (`num_client`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commande_Livreur1` FOREIGN KEY (`num_livreur`) REFERENCES `livreur` (`num_livreur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `localisation`
--
ALTER TABLE `localisation`
  ADD CONSTRAINT `fk_Localisation_Client1` FOREIGN KEY (`Client_num_client`) REFERENCES `client` (`num_client`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `produits_dans_commande`
--
ALTER TABLE `produits_dans_commande`
  ADD CONSTRAINT `fk_Commande_has_Produit_Commande1` FOREIGN KEY (`Commande_num_commande`) REFERENCES `commande` (`num_commande`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Commande_has_Produit_Produit1` FOREIGN KEY (`Produit_num_produit`) REFERENCES `produit` (`num_produit`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
