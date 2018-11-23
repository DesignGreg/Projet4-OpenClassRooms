-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 23, 2018 at 09:54 AM
-- Server version: 5.6.34-log
-- PHP Version: 7.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projet4`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `num_client` int(11) NOT NULL,
  `prenom_client` varchar(45) NOT NULL,
  `nom_client` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`num_client`, `prenom_client`, `nom_client`) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Doe');

-- --------------------------------------------------------

--
-- Table structure for table `commande`
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
-- Dumping data for table `commande`
--

INSERT INTO `commande` (`num_commande`, `date_commande`, `montant_commande`, `statut_commande`, `num_client`, `num_livreur`, `Localisation_id`) VALUES
(1, '2018-11-27 11:24:19.00', 16.00, 'livrée', 1, 1, 1),
(2, '2018-11-27 11:30:10.00', 18.00, 'livrée', 2, 2, 1),
(3, '2018-11-28 11:07:21.00', 32.00, 'en cours', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `livreur`
--

CREATE TABLE `livreur` (
  `num_livreur` int(11) NOT NULL,
  `nom_livreur` varchar(45) NOT NULL,
  `num_plats_en_stock` varchar(45) NOT NULL,
  `statut` tinyint(1) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `livreur`
--

INSERT INTO `livreur` (`num_livreur`, `nom_livreur`, `num_plats_en_stock`, `statut`, `latitude`, `longitude`) VALUES
(1, 'Coyote', '1,3', 1, 48.5102, 2.19085),
(2, 'Jaguar', '2,4', 1, 48.5102, 2.19085);

-- --------------------------------------------------------

--
-- Table structure for table `localisation`
--

CREATE TABLE `localisation` (
  `id` int(11) NOT NULL,
  `voie` varchar(45) NOT NULL,
  `complement` varchar(45) DEFAULT NULL,
  `code_postal` varchar(5) NOT NULL,
  `ville` varchar(45) NOT NULL,
  `telephone` varchar(10) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `localisation`
--

INSERT INTO `localisation` (`id`, `voie`, `complement`, `code_postal`, `ville`, `telephone`, `latitude`, `longitude`) VALUES
(1, 'rue de Sèvres', 'Bat A', '75007', 'Paris', '0606060606', 48.5102, 2.19085);

-- --------------------------------------------------------

--
-- Table structure for table `produit`
--

CREATE TABLE `produit` (
  `num_produit` int(11) NOT NULL,
  `nom_produit` varchar(45) NOT NULL,
  `type_produit` enum('plat','dessert') NOT NULL,
  `ingredients` varchar(45) NOT NULL,
  `prix` decimal(4,2) NOT NULL,
  `num_commande` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `produit`
--

INSERT INTO `produit` (`num_produit`, `nom_produit`, `type_produit`, `ingredients`, `prix`, `num_commande`) VALUES
(1, 'Spaghettis sauce bolognaise', 'plat', '', 8.00, 0),
(2, 'Sushi', 'plat', 'poisson', 9.00, 0),
(3, 'Fondant chocolat', 'dessert', '', 8.00, 0),
(4, 'salade de fruits', 'dessert', 'ananas, banane, pomme, kiwi', 9.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `produits_dans_commande`
--

CREATE TABLE `produits_dans_commande` (
  `id` int(11) NOT NULL,
  `Commande_num_commande` int(11) NOT NULL,
  `Produit_num_produit` int(11) NOT NULL,
  `quantite_produits` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `produits_dans_commande`
--

INSERT INTO `produits_dans_commande` (`id`, `Commande_num_commande`, `Produit_num_produit`, `quantite_produits`) VALUES
(1, 1, 1, 1),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 2, 4, 1),
(5, 3, 1, 2),
(6, 3, 3, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`num_client`);

--
-- Indexes for table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`num_commande`),
  ADD KEY `fk_commande_Client_idx` (`num_client`),
  ADD KEY `fk_commande_Livreur1_idx` (`num_livreur`),
  ADD KEY `fk_Commande_Localisation1_idx` (`Localisation_id`);

--
-- Indexes for table `livreur`
--
ALTER TABLE `livreur`
  ADD PRIMARY KEY (`num_livreur`);

--
-- Indexes for table `localisation`
--
ALTER TABLE `localisation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`num_produit`);

--
-- Indexes for table `produits_dans_commande`
--
ALTER TABLE `produits_dans_commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Commande_has_Produit_Produit1_idx` (`Produit_num_produit`),
  ADD KEY `fk_Commande_has_Produit_Commande1_idx` (`Commande_num_commande`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `num_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `commande`
--
ALTER TABLE `commande`
  MODIFY `num_commande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `livreur`
--
ALTER TABLE `livreur`
  MODIFY `num_livreur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `localisation`
--
ALTER TABLE `localisation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `produit`
--
ALTER TABLE `produit`
  MODIFY `num_produit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `produits_dans_commande`
--
ALTER TABLE `produits_dans_commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_Commande_Localisation1` FOREIGN KEY (`Localisation_id`) REFERENCES `localisation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commande_Client` FOREIGN KEY (`num_client`) REFERENCES `client` (`num_client`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commande_Livreur1` FOREIGN KEY (`num_livreur`) REFERENCES `livreur` (`num_livreur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `produits_dans_commande`
--
ALTER TABLE `produits_dans_commande`
  ADD CONSTRAINT `fk_Commande_has_Produit_Commande1` FOREIGN KEY (`Commande_num_commande`) REFERENCES `commande` (`num_commande`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Commande_has_Produit_Produit1` FOREIGN KEY (`Produit_num_produit`) REFERENCES `produit` (`num_produit`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
