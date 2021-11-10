-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:8889
-- Tiempo de generación: 06-11-2021 a las 13:43:55
-- Versión del servidor: 5.7.34
-- Versión de PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `retail`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transa`
--

CREATE TABLE `transa` (
  `id` int(11) NOT NULL,
  `invoice` varchar(10) NOT NULL,
  `stockcode` varchar(20) NOT NULL,
  `quantity` int(6) NOT NULL,
  `invoicedate` datetime NOT NULL,
  `price` int(6) NOT NULL,
  `customer_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `transa`
--
ALTER TABLE `transa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stockcode` (`stockcode`),
  ADD KEY `customer_id` (`customer_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `transa`
--
ALTER TABLE `transa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `transa`
--
ALTER TABLE `transa`
  ADD CONSTRAINT `transa_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `clientes` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transa_ibfk_2` FOREIGN KEY (`stockcode`) REFERENCES `productos` (`stockcode`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
