-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-06-2016 a las 05:28:44
-- Versión del servidor: 10.1.10-MariaDB
-- Versión de PHP: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `subiralproyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `idadministrador` int(11) NOT NULL,
  `nick` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `contrasena` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caracteristicas del producto`
--

CREATE TABLE `caracteristicas del producto` (
  `idcaracteristicas del producto` int(11) NOT NULL,
  `descripcion` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `costoadicional` decimal(10,0) NOT NULL,
  `producto_idproducto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `nombre` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `contraseña` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `correo` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `administrador_idadministrador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `idcompras` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `fecha` datetime DEFAULT NULL,
  `idproducto` int(11) NOT NULL,
  `cliente_idcliente` int(11) NOT NULL,
  `cliente_administrador_idadministrador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` int(11) NOT NULL,
  `servicio` varchar(45) COLLATE latin1_spanish_ci NOT NULL,
  `costo` decimal(3,0) NOT NULL,
  `idcaracteristicas` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_has_compras`
--

CREATE TABLE `producto_has_compras` (
  `producto_idproducto` int(11) NOT NULL,
  `compras_idcompras` int(11) NOT NULL,
  `compras_cliente_idcliente` int(11) NOT NULL,
  `compras_cliente_administrador_idadministrador` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`idadministrador`),
  ADD UNIQUE KEY `nick_UNIQUE` (`nick`);

--
-- Indices de la tabla `caracteristicas del producto`
--
ALTER TABLE `caracteristicas del producto`
  ADD PRIMARY KEY (`idcaracteristicas del producto`,`producto_idproducto`),
  ADD KEY `fk_caracteristicas del producto_producto1_idx` (`producto_idproducto`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`,`administrador_idadministrador`),
  ADD UNIQUE KEY `correo_UNIQUE` (`correo`),
  ADD KEY `fk_cliente_administrador_idx` (`administrador_idadministrador`),
  ADD KEY `idcliente` (`idcliente`),
  ADD KEY `idcliente_2` (`idcliente`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`idcompras`,`cliente_idcliente`,`cliente_administrador_idadministrador`),
  ADD KEY `fk_compras_cliente1_idx` (`cliente_idcliente`,`cliente_administrador_idadministrador`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`);

--
-- Indices de la tabla `producto_has_compras`
--
ALTER TABLE `producto_has_compras`
  ADD PRIMARY KEY (`producto_idproducto`,`compras_idcompras`,`compras_cliente_idcliente`,`compras_cliente_administrador_idadministrador`),
  ADD KEY `fk_producto_has_compras_compras1_idx` (`compras_idcompras`,`compras_cliente_idcliente`,`compras_cliente_administrador_idadministrador`),
  ADD KEY `fk_producto_has_compras_producto1_idx` (`producto_idproducto`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `caracteristicas del producto`
--
ALTER TABLE `caracteristicas del producto`
  ADD CONSTRAINT `fk_caracteristicas del producto_producto1` FOREIGN KEY (`producto_idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_administrador` FOREIGN KEY (`administrador_idadministrador`) REFERENCES `administrador` (`idadministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `fk_compras_cliente1` FOREIGN KEY (`cliente_idcliente`,`cliente_administrador_idadministrador`) REFERENCES `cliente` (`idcliente`, `administrador_idadministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `producto_has_compras`
--
ALTER TABLE `producto_has_compras`
  ADD CONSTRAINT `fk_producto_has_compras_compras1` FOREIGN KEY (`compras_idcompras`,`compras_cliente_idcliente`,`compras_cliente_administrador_idadministrador`) REFERENCES `compras` (`idcompras`, `cliente_idcliente`, `cliente_administrador_idadministrador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_producto_has_compras_producto1` FOREIGN KEY (`producto_idproducto`) REFERENCES `producto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
