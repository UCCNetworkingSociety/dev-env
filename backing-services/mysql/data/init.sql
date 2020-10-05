CREATE USER IF NOT EXISTS 'pterodactyl'@'127.0.0.1' IDENTIFIED BY 'password';
CREATE DATABASE IF NOT EXISTS panel;
CREATE DATABASE IF NOT EXISTS promexporter;
GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1' WITH GRANT OPTION;
FLUSH PRIVILEGES;
DROP TABLE IF EXISTS schedules;

USE panel;
SET GLOBAL FOREIGN_KEY_CHECKS=0;

-- SQL Dump for games panel configuration

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `panel`
--

-- --------------------------------------------------------

--
-- Table structure for table `allocations`
--

CREATE TABLE `allocations` (
  `id` int(10) UNSIGNED NOT NULL,
  `node_id` int(10) UNSIGNED NOT NULL,
  `ip` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_alias` text COLLATE utf8mb4_unicode_ci,
  `port` mediumint(8) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED DEFAULT NULL,
  `notes` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `allocations`
--

INSERT INTO `allocations` (`id`, `node_id`, `ip`, `ip_alias`, `port`, `server_id`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, '127.0.0.1', 'localhost', 1045, 1, NULL, NULL, '2020-09-18 16:05:11');

-- --------------------------------------------------------

--
-- Table structure for table `api_keys`
--

CREATE TABLE `api_keys` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `key_type` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `identifier` char(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `allowed_ips` text COLLATE utf8mb4_unicode_ci,
  `memo` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `r_servers` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_nodes` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_allocations` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_users` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_locations` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_nests` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_eggs` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_database_hosts` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `r_server_databases` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_logs`
--

CREATE TABLE `api_logs` (
  `id` int(10) UNSIGNED NOT NULL,
  `authorized` tinyint(1) NOT NULL,
  `error` text COLLATE utf8mb4_unicode_ci,
  `key` char(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` char(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `user_agent` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `request_ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `backups`
--

CREATE TABLE `backups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_successful` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ignored_files` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `disk` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksum` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bytes` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `databases`
--

CREATE TABLE `databases` (
  `id` int(10) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `database_host_id` int(10) UNSIGNED NOT NULL,
  `database` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remote` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '%',
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_connections` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `database_hosts`
--

CREATE TABLE `database_hosts` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `port` int(10) UNSIGNED NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_databases` int(10) UNSIGNED DEFAULT NULL,
  `node_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eggs`
--

CREATE TABLE `eggs` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nest_id` int(10) UNSIGNED NOT NULL,
  `author` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `docker_image` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `config_files` text COLLATE utf8mb4_unicode_ci,
  `config_startup` text COLLATE utf8mb4_unicode_ci,
  `config_logs` text COLLATE utf8mb4_unicode_ci,
  `config_stop` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_from` int(10) UNSIGNED DEFAULT NULL,
  `startup` text COLLATE utf8mb4_unicode_ci,
  `script_container` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'alpine:3.4',
  `copy_script_from` int(10) UNSIGNED DEFAULT NULL,
  `script_entry` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ash',
  `script_is_privileged` tinyint(1) NOT NULL DEFAULT '1',
  `script_install` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `eggs`
--

INSERT INTO `eggs` (`id`, `uuid`, `nest_id`, `author`, `name`, `description`, `docker_image`, `config_files`, `config_startup`, `config_logs`, `config_stop`, `config_from`, `startup`, `script_container`, `copy_script_from`, `script_entry`, `script_is_privileged`, `script_install`, `created_at`, `updated_at`) VALUES
(1, 'e19017ef-805b-4012-bc32-ecd52da7530a', 1, 'support@pterodactyl.io', 'Bungeecord', 'For a long time, Minecraft server owners have had a dream that encompasses a free, easy, and reliable way to connect multiple Minecraft servers together. BungeeCord is the answer to said dream. Whether you are a small server wishing to string multiple game-modes together, or the owner of the ShotBow Network, BungeeCord is the ideal solution for you. With the help of BungeeCord, you will be able to unlock your community\'s full potential.', 'quay.io/pterodactyl/core:java', '{\r\n    \"config.yml\": {\r\n        \"parser\": \"yaml\",\r\n        \"find\": {\r\n            \"listeners[0].query_enabled\": true,\r\n            \"listeners[0].query_port\": \"{{server.build.default.port}}\",\r\n            \"listeners[0].host\": \"0.0.0.0:{{server.build.default.port}}\",\r\n            \"servers.*.address\": {\r\n                \"regex:^(127\\\\.0\\\\.0\\\\.1|localhost)(:\\\\d{1,5})?$\": \"{{config.docker.interface}}$2\"\r\n            }\r\n        }\r\n    }\r\n}', '{\r\n    \"done\": \"Listening on \",\r\n    \"userInteraction\": [\r\n        \"Listening on /0.0.0.0:25577\"\r\n    ]\r\n}', '{\r\n    \"custom\": false,\r\n    \"location\": \"proxy.log.0\"\r\n}', 'end', NULL, 'java -Xms128M -Xmx{{SERVER_MEMORY}}M -jar {{SERVER_JARFILE}}', 'alpine:3.9', NULL, 'ash', 1, '#!/bin/ash\n# Bungeecord Installation Script\n#\n# Server Files: /mnt/server\napk update\napk add curl\n\ncd /mnt/server\n\nif [ -z \"${BUNGEE_VERSION}\" ] || [ \"${BUNGEE_VERSION}\" == \"latest\" ]; then\n    BUNGEE_VERSION=\"lastStableBuild\"\nfi\n\ncurl -o ${SERVER_JARFILE} https://ci.md-5.net/job/BungeeCord/${BUNGEE_VERSION}/artifact/bootstrap/target/BungeeCord.jar', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(2, '9f51b84d-a3c3-4b1f-a2f7-6f4b19d36e7b', 1, 'support@pterodactyl.io', 'Forge Minecraft', 'Minecraft Forge Server. Minecraft Forge is a modding API (Application Programming Interface), which makes it easier to create mods, and also make sure mods are compatible with each other.', 'quay.io/pterodactyl/core:java', '{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"enable-query\": \"true\",\r\n            \"server-port\": \"{{server.build.default.port}}\",\r\n            \"query.port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}', '{\r\n    \"done\": \")! For help, type \",\r\n    \"userInteraction\": [\r\n        \"Go to eula.txt for more info.\"\r\n    ]\r\n}', '{\r\n    \"custom\": false,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'stop', NULL, 'java -Xms128M -Xmx{{SERVER_MEMORY}}M -jar {{SERVER_JARFILE}}', 'openjdk:8-jdk-slim', NULL, 'bash', 1, '#!/bin/bash\r\n# Forge Installation Script\r\n#\r\n# Server Files: /mnt/server\r\napt update\r\napt install -y curl jq\r\n\r\n#Go into main direction\r\nif [ ! -d /mnt/server ]; then\r\n    mkdir /mnt/server\r\nfi\r\n\r\ncd /mnt/server\r\n\r\nif [ ! -z ${FORGE_VERSION} ]; then\r\n    DOWNLOAD_LINK=https://files.minecraftforge.net/maven/net/minecraftforge/forge/${FORGE_VERSION}/forge-${FORGE_VERSION}\r\nelse\r\n    JSON_DATA=$(curl -sSL https://files.minecraftforge.net/maven/net/minecraftforge/forge/promotions_slim.json)\r\n\r\n    if [ \"${MC_VERSION}\" == \"latest\" ] || [ \"${MC_VERSION}\" == \"\" ] ; then\r\n        echo -e \"getting latest recommended version of forge.\"\r\n        MC_VERSION=$(echo -e ${JSON_DATA} | jq -r \'.promos | del(.\"latest-1.7.10\") | del(.\"1.7.10-latest-1.7.10\") | to_entries[] | .key | select(contains(\"recommended\")) | split(\"-\")[0]\' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | tail -1)\r\n    	BUILD_TYPE=recommended\r\n    fi\r\n\r\n    if [ \"${BUILD_TYPE}\" != \"recommended\" ] && [ \"${BUILD_TYPE}\" != \"latest\" ]; then\r\n        BUILD_TYPE=recommended\r\n    fi\r\n\r\n    echo -e \"minecraft version: ${MC_VERSION}\"\r\n    echo -e \"build type: ${BUILD_TYPE}\"\r\n\r\n    ## some variables for getting versions and things\r\n    FILE_SITE=$(echo -e ${JSON_DATA} | jq -r \'.homepage\' | sed \"s/http:/https:/g\")\r\n    VERSION_KEY=$(echo -e ${JSON_DATA} | jq -r --arg MC_VERSION \"${MC_VERSION}\" --arg BUILD_TYPE \"${BUILD_TYPE}\" \'.promos | del(.\"latest-1.7.10\") | del(.\"1.7.10-latest-1.7.10\") | to_entries[] | .key | select(contains($MC_VERSION)) | select(contains($BUILD_TYPE))\')\r\n\r\n    ## locating the forge version\r\n    if [ \"${VERSION_KEY}\" == \"\" ] && [ \"${BUILD_TYPE}\" == \"recommended\" ]; then\r\n        echo -e \"dropping back to latest from recommended due to there not being a recommended version of forge for the mc version requested.\"\r\n        VERSION_KEY=$(echo -e ${JSON_DATA} | jq -r --arg MC_VERSION \"${MC_VERSION}\" \'.promos | del(.\"latest-1.7.10\") | del(.\"1.7.10-latest-1.7.10\") | to_entries[] | .key | select(contains($MC_VERSION)) | select(contains(\"recommended\"))\')\r\n    fi\r\n\r\n    ## Error if the mc version set wasn\'t valid.\r\n    if [ \"${VERSION_KEY}\" == \"\" ] || [ \"${VERSION_KEY}\" == \"null\" ]; then\r\n    	echo -e \"The install failed because there is no valid version of forge for the version on minecraft selected.\"\r\n    	exit 1\r\n    fi\r\n\r\n    FORGE_VERSION=$(echo -e ${JSON_DATA} | jq -r --arg VERSION_KEY \"$VERSION_KEY\" \'.promos | .[$VERSION_KEY]\')\r\n\r\n    if [ \"${MC_VERSION}\" == \"1.7.10\" ] || [ \"${MC_VERSION}\" == \"1.8.9\" ]; then\r\n        DOWNLOAD_LINK=${FILE_SITE}${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}\r\n        FORGE_JAR=forge-${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}.jar\r\n        if [ \"${MC_VERSION}\" == \"1.7.10\" ]; then\r\n            FORGE_JAR=forge-${MC_VERSION}-${FORGE_VERSION}-${MC_VERSION}-universal.jar\r\n        fi\r\n    else\r\n        DOWNLOAD_LINK=${FILE_SITE}${MC_VERSION}-${FORGE_VERSION}/forge-${MC_VERSION}-${FORGE_VERSION}\r\n        FORGE_JAR=forge-${MC_VERSION}-${FORGE_VERSION}.jar\r\n    fi\r\nfi\r\n\r\n\r\n#Adding .jar when not eding by SERVER_JARFILE\r\nif [[ ! $SERVER_JARFILE = *\\.jar ]]; then\r\n  SERVER_JARFILE=\"$SERVER_JARFILE.jar\"\r\nfi\r\n\r\n#Downloading jars\r\necho -e \"Downloading forge version ${FORGE_VERSION}\"\r\nif [ ! -z \"${DOWNLOAD_LINK}\" ]; then \r\n    if curl --output /dev/null --silent --head --fail ${DOWNLOAD_LINK}-installer.jar; then\r\n        echo -e \"installer jar download link is valid.\"\r\n    else\r\n        echo -e \"link is invalid closing out\"\r\n        exit 2\r\n    fi\r\n\r\n    echo -e \"no download link closing out\"\r\n    exit 3\r\nfi\r\n\r\ncurl -s -o installer.jar -sS ${DOWNLOAD_LINK}-installer.jar\r\n\r\n#Checking if downloaded jars exist\r\nif [ ! -f ./installer.jar ]; then\r\n    echo \"!!! Error by downloading forge version ${FORGE_VERSION} !!!\"\r\n    exit\r\nfi\r\n\r\n#Installing server\r\necho -e \"Installing forge server.\\n\"\r\njava -jar installer.jar --installServer || { echo -e \"install failed\"; exit 4; }\r\n\r\nmv $FORGE_JAR $SERVER_JARFILE\r\n\r\n#Deleting installer.jar\r\necho -e \"Deleting installer.jar file.\\n\"\r\nrm -rf installer.jar', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(3, '2ffe5a37-8918-4824-b560-5cdc0a549811', 1, 'parker@pterodactyl.io', 'Paper', 'High performance Spigot fork that aims to fix gameplay and mechanics inconsistencies.', 'quay.io/pterodactyl/core:java', '{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"server-port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}', '{\r\n    \"done\": \")! For help, type \",\r\n    \"userInteraction\": [\r\n        \"Go to eula.txt for more info.\"\r\n    ]\r\n}', '{}', 'stop', NULL, 'java -Xms128M -Xmx{{SERVER_MEMORY}}M -Dterminal.jline=false -Dterminal.ansi=true -jar {{SERVER_JARFILE}}', 'alpine:3.9', NULL, 'ash', 1, '#!/bin/ash\r\n# Paper Installation Script\r\n#\r\n# Server Files: /mnt/server\r\napk add --no-cache --update curl jq\r\n\r\nif [ -n \"${DL_PATH}\" ]; then\r\n    echo -e \"using supplied download url\"\r\n    DOWNLOAD_URL=`eval echo $(echo ${DL_PATH} | sed -e \'s/{{/${/g\' -e \'s/}}/}/g\')`\r\nelse\r\n    VER_EXISTS=`curl -s https://papermc.io/api/v1/paper | jq -r --arg VERSION $MINECRAFT_VERSION \'.versions[] | IN($VERSION)\' | grep true`\r\n    LATEST_PAPER_VERSION=`curl -s https://papermc.io/api/v1/paper | jq -r \'.versions\' | jq -r \'.[0]\'`\r\n    \r\n    if [ \"${VER_EXISTS}\" == \"true\" ]; then\r\n        echo -e \"Version is valid. Using version ${MINECRAFT_VERSION}\"\r\n    else\r\n        echo -e \"Using the latest paper version\"\r\n        MINECRAFT_VERSION=${LATEST_PAPER_VERSION}\r\n    fi\r\n    \r\n    BUILD_EXISTS=`curl -s https://papermc.io/api/v1/paper/${MINECRAFT_VERSION} | jq -r --arg BUILD ${BUILD_NUMBER} \'.builds.all[] | IN($BUILD)\' | grep true`\r\n    LATEST_PAPER_BUILD=`curl -s https://papermc.io/api/v1/paper/${MINECRAFT_VERSION} | jq -r \'.builds.latest\'`\r\n    \r\n    if [ \"${BUILD_EXISTS}\" == \"true\" ] || [ ${BUILD_NUMBER} == \"latest\" ]; then\r\n        echo -e \"Build is valid. Using version ${BUILD_NUMBER}\"\r\n    else\r\n        echo -e \"Using the latest paper build\"\r\n        BUILD_NUMBER=${LATEST_PAPER_BUILD}\r\n    fi\r\n    \r\n    echo \"Version being downloaded\"\r\n    echo -e \"MC Version: ${MINECRAFT_VERSION}\"\r\n    echo -e \"Build: ${BUILD_NUMBER}\"\r\n    DOWNLOAD_URL=https://papermc.io/api/v1/paper/${MINECRAFT_VERSION}/${BUILD_NUMBER}/download \r\nfi\r\n\r\ncd /mnt/server\r\n\r\necho -e \"running curl -o ${SERVER_JARFILE} ${DOWNLOAD_URL}\"\r\n\r\nif [ -f ${SERVER_JARFILE} ]; then\r\n    mv ${SERVER_JARFILE} ${SERVER_JARFILE}.old\r\nfi\r\n\r\ncurl -o ${SERVER_JARFILE} ${DOWNLOAD_URL}\r\n\r\nif [ ! -f server.properties ]; then\r\n    echo -e \"Downloading MC server.properties\"\r\n    curl -o server.properties https://raw.githubusercontent.com/parkervcp/eggs/master/minecraft_java/server.properties\r\nfi', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(4, 'c6970545-c4bf-4e06-ba85-7390d4833578', 1, 'support@pterodactyl.io', 'Sponge (SpongeVanilla)', 'SpongeVanilla is the SpongeAPI implementation for Vanilla Minecraft.', 'quay.io/pterodactyl/core:java-glibc', '{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"enable-query\": \"true\",\r\n            \"server-port\": \"{{server.build.default.port}}\",\r\n            \"query.port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}', '{\r\n    \"done\": \")! For help, type \",\r\n    \"userInteraction\": [\r\n        \"Go to eula.txt for more info.\"\r\n    ]\r\n}', '{\r\n    \"custom\": false,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'stop', NULL, 'java -Xms128M -Xmx{{SERVER_MEMORY}}M -jar {{SERVER_JARFILE}}', 'alpine:3.9', NULL, 'ash', 1, '#!/bin/ash\n# Sponge Installation Script\n#\n# Server Files: /mnt/server\n\napk update\napk add curl\n\ncd /mnt/server\n\ncurl -sSL \"https://repo.spongepowered.org/maven/org/spongepowered/spongevanilla/${SPONGE_VERSION}/spongevanilla-${SPONGE_VERSION}.jar\" -o ${SERVER_JARFILE}', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(5, 'df51c666-6b9b-4cba-9458-56a30ee9d1db', 1, 'support@pterodactyl.io', 'Vanilla Minecraft', 'Minecraft is a game about placing blocks and going on adventures. Explore randomly generated worlds and build amazing things from the simplest of homes to the grandest of castles. Play in Creative Mode with unlimited resources or mine deep in Survival Mode, crafting weapons and armor to fend off dangerous mobs. Do all this alone or with friends.', 'quay.io/pterodactyl/core:java', '{\r\n    \"server.properties\": {\r\n        \"parser\": \"properties\",\r\n        \"find\": {\r\n            \"server-ip\": \"0.0.0.0\",\r\n            \"enable-query\": \"true\",\r\n            \"server-port\": \"{{server.build.default.port}}\"\r\n        }\r\n    }\r\n}', '{\r\n    \"done\": \")! For help, type \",\r\n    \"userInteraction\": [\r\n        \"Go to eula.txt for more info.\"\r\n    ]\r\n}', '{\r\n    \"custom\": false,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'stop', NULL, 'java -Xms128M -Xmx{{SERVER_MEMORY}}M -jar {{SERVER_JARFILE}}', 'alpine:3.10', NULL, 'ash', 1, '#!/bin/ash\r\n# Vanilla MC Installation Script\r\n#\r\n# Server Files: /mnt/server\r\napk add curl --no-cache --update jq\r\n\r\nmkdir -p /mnt/server\r\ncd /mnt/server\r\n\r\nLATEST_VERSION=`curl https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r \'.latest.release\'`\r\n\r\necho -e \"latest version is $LATEST_VERSION\"\r\n\r\nif [ -z \"$VANILLA_VERSION\" ] || [ \"$VANILLA_VERSION\" == \"latest\" ]; then\r\n  MANIFEST_URL=$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json | jq --arg VERSION $LATEST_VERSION -r \'.versions | .[] | select(.id== $VERSION )|.url\')\r\nelse\r\n  MANIFEST_URL=$(curl -sSL https://launchermeta.mojang.com/mc/game/version_manifest.json | jq --arg VERSION $VANILLA_VERSION -r \'.versions | .[] | select(.id== $VERSION )|.url\')\r\nfi\r\n\r\nDOWNLOAD_URL=$(curl ${MANIFEST_URL} | jq .downloads.server | jq -r \'. | .url\')\r\n\r\necho -e \"running: curl -o ${SERVER_JARFILE} $DOWNLOAD_URL\"\r\ncurl -o ${SERVER_JARFILE} $DOWNLOAD_URL\r\n\r\necho -e \"Install Complete\"', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(6, 'fd9cbeb3-7826-4479-b71b-1961594dd2d3', 2, 'support@pterodactyl.io', 'Ark: Survival Evolved', 'As a man or woman stranded, naked, freezing, and starving on the unforgiving shores of a mysterious island called ARK, use your skill and cunning to kill or tame and ride the plethora of leviathan dinosaurs and other primeval creatures roaming the land. Hunt, harvest resources, craft items, grow crops, research technologies, and build shelters to withstand the elements and store valuables, all while teaming up with (or preying upon) hundreds of other players to survive, dominate... and escape! — Gamepedia: ARK', 'quay.io/pterodactyl/core:source', '{}', '{\r\n    \"done\": \"Setting breakpad minidump AppID = 346110\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": true,\r\n    \"location\": \"logs/latest.log\"\r\n}', '^C', NULL, '\"cd ShooterGame/Binaries/Linux && ./ShooterGameServer {{SERVER_MAP}}?listen?SessionName=\'{{SESSION_NAME}}\'?ServerPassword={{ARK_PASSWORD}}?ServerAdminPassword={{ARK_ADMIN_PASSWORD}}?Port={{PORT}}?MaxPlayers={{SERVER_MAX_PLAYERS}}?RCONPort={{RCON_PORT}}?QueryPort={{QUERY_PORT}}?RCONEnabled={{ENABLE_RCON}} -server -log\"', 'ubuntu:16.04', NULL, 'bash', 1, '#!/bin/bash\r\n# ARK: Installation Script\r\n#\r\n# Server Files: /mnt/server\r\napt -y update\r\napt -y --no-install-recommends install curl lib32gcc1 ca-certificates\r\n\r\ncd /tmp\r\ncurl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz\r\n\r\nmkdir -p /mnt/server/steamcmd\r\nmkdir -p /mnt/server/Engine/Binaries/ThirdParty/SteamCMD/Linux\r\n\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/Engine/Binaries/ThirdParty/SteamCMD/Linux\r\n\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\n\r\nexport HOME=/mnt/server\r\n./steamcmd.sh +login anonymous +force_install_dir /mnt/server +app_update 376030 +quit\r\n\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\ncd /mnt/server/Engine/Binaries/ThirdParty/SteamCMD/Linux\r\n\r\nln -sf ../../../../../Steam/steamapps steamapps\r\n\r\ncd /mnt/server', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(7, 'c128fb68-28bb-454a-8b80-21f65d7657ed', 2, 'support@pterodactyl.io', 'Counter-Strike: Global Offensive', 'Counter-Strike: Global Offensive is a multiplayer first-person shooter video game developed by Hidden Path Entertainment and Valve Corporation.', 'quay.io/pterodactyl/core:source', '{}', '{\r\n    \"done\": \"Connection to Steam servers successful\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": true,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'quit', NULL, './srcds_run -game csgo -console -port {{SERVER_PORT}} +ip 0.0.0.0 +map {{SRCDS_MAP}} -strictportbind -norestart +sv_setsteamaccount {{STEAM_ACC}}', 'ubuntu:18.04', NULL, 'bash', 1, '#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'ubuntu:18.04\'\r\napt -y update\r\napt -y --no-install-recommends install curl lib32gcc1 ca-certificates\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +force_install_dir /mnt/server +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(8, 'b8c584d8-f6d3-4dae-a80e-2f61131a9e01', 2, 'support@pterodactyl.io', 'Custom Source Engine Game', 'This option allows modifying the startup arguments and other details to run a custom SRCDS based game on the panel.', 'quay.io/pterodactyl/core:source', '{}', '{\r\n    \"done\": \"gameserver Steam ID\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": true,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'quit', NULL, './srcds_run -game {{SRCDS_GAME}} -console -port {{SERVER_PORT}} +map {{SRCDS_MAP}} +ip 0.0.0.0 -strictportbind -norestart', 'ubuntu:18.04', NULL, 'bash', 1, '#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'ubuntu:18.04\'\r\napt -y update\r\napt -y --no-install-recommends install curl lib32gcc1 ca-certificates\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +force_install_dir /mnt/server +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(9, '4763f733-15b7-454c-a0df-639099ab7041', 2, 'support@pterodactyl.io', 'Garrys Mod', 'Garrys Mod, is a sandbox physics game created by Garry Newman, and developed by his company, Facepunch Studios.', 'quay.io/pterodactyl/core:source', '{}', '{\r\n    \"done\": \"gameserver Steam ID\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": true,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'quit', NULL, './srcds_run -game garrysmod -console -port {{SERVER_PORT}} +ip 0.0.0.0 +host_workshop_collection {{WORKSHOP_ID}} +map {{SRCDS_MAP}} +gamemode {{GAMEMODE}} -strictportbind -norestart +sv_setsteamaccount {{STEAM_ACC}} +maxplayers {{MAX_PLAYERS}}  -tickrate {{TICKRATE}}', 'ubuntu:18.04', NULL, 'bash', 1, '#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'ubuntu:18.04\'\r\napt -y update\r\napt -y --no-install-recommends install curl lib32gcc1 ca-certificates\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +force_install_dir /mnt/server +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so\r\n\r\n# Creating needed default files for the game\r\ncd /mnt/server/garrysmod/lua/autorun/server\r\necho \'\r\n-- Docs: https://wiki.garrysmod.com/page/resource/AddWorkshop\r\n-- Place the ID of the workshop addon you want to be downloaded to people who join your server, not the collection ID\r\n-- Use https://beta.configcreator.com/create/gmod/resources.lua to easily create a list based on your collection ID\r\n\r\nresource.AddWorkshop( \"\" )\r\n\' > workshop.lua\r\n\r\ncd /mnt/server/garrysmod/cfg\r\necho \'\r\n// Please do not set RCon in here, use the startup parameters.\r\n\r\nhostname		\"New Gmod Server\"\r\nsv_password		\"\"\r\nsv_loadingurl   \"\"\r\n\r\n// Steam Server List Settings\r\nsv_region \"255\"\r\nsv_lan \"0\"\r\nsv_max_queries_sec_global \"30000\"\r\nsv_max_queries_window \"45\"\r\nsv_max_queries_sec \"5\"\r\n\r\n// Server Limits\r\nsbox_maxprops		100\r\nsbox_maxragdolls	5\r\nsbox_maxnpcs		10\r\nsbox_maxballoons	10\r\nsbox_maxeffects		10\r\nsbox_maxdynamite	10\r\nsbox_maxlamps		10\r\nsbox_maxthrusters	10\r\nsbox_maxwheels		10\r\nsbox_maxhoverballs	10\r\nsbox_maxvehicles	20\r\nsbox_maxbuttons		10\r\nsbox_maxsents		20\r\nsbox_maxemitters	5\r\nsbox_godmode		0\r\nsbox_noclip		    0\r\n\r\n// Network Settings - Please keep these set to default.\r\n\r\nsv_minrate		75000\r\nsv_maxrate		0\r\ngmod_physiterations	2\r\nnet_splitpacket_maxrate	45000\r\ndecalfrequency		12 \r\n\r\n// Execute Ban Files - Please do not edit\r\nexec banned_ip.cfg \r\nexec banned_user.cfg \r\n\r\n// Add custom lines under here\r\n\' > server.cfg', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(10, 'd74cf20c-8eb0-40ee-ae73-ec4f016ed4bc', 2, 'support@pterodactyl.io', 'Insurgency', 'Take to the streets for intense close quarters combat, where a team\'s survival depends upon securing crucial strongholds and destroying enemy supply in this multiplayer and cooperative Source Engine based experience.', 'quay.io/pterodactyl/core:source', '{}', '{\"done\": \"gameserver Steam ID\", \"userInteraction\": []}', '{\"custom\": true, \"location\": \"logs/latest.log\"}', 'quit', NULL, './srcds_run -game {{SRCDS_GAME}} -console -port {{SERVER_PORT}} +map {{SRCDS_MAP}} +ip 0.0.0.0 -strictportbind -norestart', 'ubuntu:18.04', NULL, 'bash', 1, '#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'ubuntu:18.04\'\r\napt -y update\r\napt -y --no-install-recommends install curl lib32gcc1 ca-certificates\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +force_install_dir /mnt/server +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(11, '1194e7b1-e0b1-4177-8115-24f3eb4290f0', 2, 'support@pterodactyl.io', 'Team Fortress 2', 'Team Fortress 2 is a team-based first-person shooter multiplayer video game developed and published by Valve Corporation. It is the sequel to the 1996 mod Team Fortress for Quake and its 1999 remake.', 'quay.io/pterodactyl/core:source', '{}', '{\r\n    \"done\": \"gameserver Steam ID\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": true,\r\n    \"location\": \"logs/latest.log\"\r\n}', 'quit', NULL, './srcds_run -game {{SRCDS_GAME}} -console -port {{SERVER_PORT}} +map {{SRCDS_MAP}} +ip 0.0.0.0 -strictportbind -norestart', 'ubuntu:18.04', NULL, 'bash', 1, '#!/bin/bash\r\n# steamcmd Base Installation Script\r\n#\r\n# Server Files: /mnt/server\r\n# Image to install with is \'ubuntu:18.04\'\r\napt -y update\r\napt -y --no-install-recommends install curl lib32gcc1 ca-certificates\r\n\r\n## just in case someone removed the defaults.\r\nif [ \"${STEAM_USER}\" == \"\" ]; then\r\n    STEAM_USER=anonymous\r\n    STEAM_PASS=\"\"\r\n    STEAM_AUTH=\"\"\r\nfi\r\n\r\n## download and install steamcmd\r\ncd /tmp\r\nmkdir -p /mnt/server/steamcmd\r\ncurl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd\r\ncd /mnt/server/steamcmd\r\n\r\n# SteamCMD fails otherwise for some reason, even running as root.\r\n# This is changed at the end of the install process anyways.\r\nchown -R root:root /mnt\r\nexport HOME=/mnt/server\r\n\r\n## install game using steamcmd\r\n./steamcmd.sh +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} +force_install_dir /mnt/server +app_update ${SRCDS_APPID} ${EXTRA_FLAGS} +quit ## other flags may be needed depending on install. looking at you cs 1.6\r\n\r\n## set up 32 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so\r\n\r\n## set up 64 bit libraries\r\nmkdir -p /mnt/server/.steam/sdk64\r\ncp -v linux64/steamclient.so ../.steam/sdk64/steamclient.so', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(12, '44b0a3e9-58ea-4a01-94cb-8b94cb60d088', 3, 'support@pterodactyl.io', 'Mumble Server', 'Mumble is an open source, low-latency, high quality voice chat software primarily intended for use while gaming.', 'quay.io/pterodactyl/core:glibc', '{\"murmur.ini\":{\"parser\": \"ini\", \"find\":{\"logfile\": \"murmur.log\", \"port\": \"{{server.build.default.port}}\", \"host\": \"0.0.0.0\", \"users\": \"{{server.build.env.MAX_USERS}}\"}}}', '{\"done\": \"Server listening on\", \"userInteraction\": [ \"Generating new server certificate\"]}', '{\"custom\": true, \"location\": \"logs/murmur.log\"}', '^C', NULL, './murmur.x86 -fg', 'alpine:3.9', NULL, 'ash', 1, '#!/bin/ash\n# Mumble Installation Script\n#\n# Server Files: /mnt/server\napk update\napk add tar curl\n\ncd /tmp\n\ncurl -sSLO https://github.com/mumble-voip/mumble/releases/download/${MUMBLE_VERSION}/murmur-static_x86-${MUMBLE_VERSION}.tar.bz2\n\ntar -xjvf murmur-static_x86-${MUMBLE_VERSION}.tar.bz2\ncp -r murmur-static_x86-${MUMBLE_VERSION}/* /mnt/server', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(13, 'a3494c96-95f4-4c0c-8af7-d9b30e60d1d1', 3, 'support@pterodactyl.io', 'Teamspeak3 Server', 'VoIP software designed with security in mind, featuring crystal clear voice quality, endless customization options, and scalabilty up to thousands of simultaneous users.', 'quay.io/parkervcp/pterodactyl-images:base_debian', '{}', '{\r\n    \"done\": \"listening on 0.0.0.0:\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": true,\r\n    \"location\": \"logs/ts3.log\"\r\n}', '^C', NULL, './ts3server default_voice_port={{SERVER_PORT}} query_port={{SERVER_PORT}} filetransfer_ip=0.0.0.0 filetransfer_port={{FILE_TRANSFER}} license_accepted=1', 'alpine:3.9', NULL, 'ash', 1, '#!/bin/ash\r\n# TS3 Installation Script\r\n#\r\n# Server Files: /mnt/server\r\napk add --no-cache tar curl jq\r\n\r\nif [ -z ${TS_VERSION} ] || [ ${TS_VERSION} == latest ]; then\r\n    TS_VERSION=$(wget https://teamspeak.com/versions/server.json -qO - | jq -r \'.linux.x86_64.version\')\r\nfi\r\n\r\ncd /mnt/server\r\n\r\n\r\necho -e \"getting files from http://files.teamspeak-services.com/releases/server/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2\"\r\ncurl http://files.teamspeak-services.com/releases/server/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2 | tar xj --strip-components=1', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(14, '9ac73929-08d8-440b-a69a-7c56451401e0', 4, 'support@pterodactyl.io', 'Rust', 'The only aim in Rust is to survive. To do this you will need to overcome struggles such as hunger, thirst and cold. Build a fire. Build a shelter. Kill animals for meat. Protect yourself from other players, and kill them for meat. Create alliances with other players and form a town. Do whatever it takes to survive.', 'quay.io/pterodactyl/core:rust', '{}', '{\r\n    \"done\": \"Server startup complete\",\r\n    \"userInteraction\": []\r\n}', '{\r\n    \"custom\": false,\r\n    \"location\": \"latest.log\"\r\n}', 'quit', NULL, './RustDedicated -batchmode +server.port {{SERVER_PORT}} +server.identity \"rust\" +rcon.port {{RCON_PORT}} +rcon.web true +server.hostname \\\"{{HOSTNAME}}\\\" +server.level \\\"{{LEVEL}}\\\" +server.description \\\"{{DESCRIPTION}}\\\" +server.url \\\"{{SERVER_URL}}\\\" +server.headerimage \\\"{{SERVER_IMG}}\\\" +server.worldsize \\\"{{WORLD_SIZE}}\\\" +server.seed \\\"{{WORLD_SEED}}\\\" +server.maxplayers {{MAX_PLAYERS}} +rcon.password \\\"{{RCON_PASS}}\\\" +server.saveinterval {{SAVEINTERVAL}} {{ADDITIONAL_ARGS}}', 'ubuntu:16.04', NULL, 'bash', 1, 'apt update\r\napt -y --no-install-recommends install curl unzip lib32gcc1 ca-certificates\r\ncd /tmp\r\ncurl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz\r\n\r\nmkdir -p /mnt/server/steam\r\ntar -xzvf steamcmd.tar.gz -C /mnt/server/steam\r\ncd /mnt/server/steam\r\nchown -R root:root /mnt\r\n\r\nexport HOME=/mnt/server\r\n./steamcmd.sh +login anonymous +force_install_dir /mnt/server +app_update 258550 +quit\r\nmkdir -p /mnt/server/.steam/sdk32\r\ncp -v /mnt/server/steam/linux32/steamclient.so /mnt/server/.steam/sdk32/steamclient.so', '2020-09-17 23:37:42', '2020-09-17 23:37:42');

-- --------------------------------------------------------

--
-- Table structure for table `egg_mount`
--

CREATE TABLE `egg_mount` (
  `egg_id` int(11) NOT NULL,
  `mount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `egg_variables`
--

CREATE TABLE `egg_variables` (
  `id` int(10) UNSIGNED NOT NULL,
  `egg_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `env_variable` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `default_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_viewable` tinyint(3) UNSIGNED NOT NULL,
  `user_editable` tinyint(3) UNSIGNED NOT NULL,
  `rules` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `egg_variables`
--

INSERT INTO `egg_variables` (`id`, `egg_id`, `name`, `description`, `env_variable`, `default_value`, `user_viewable`, `user_editable`, `rules`, `created_at`, `updated_at`) VALUES
(1, 1, 'Bungeecord Version', 'The version of Bungeecord to download and use.', 'BUNGEE_VERSION', 'latest', 1, 1, 'required|alpha_num|between:1,6', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(2, 1, 'Bungeecord Jar File', 'The name of the Jarfile to use when running Bungeecord.', 'SERVER_JARFILE', 'bungeecord.jar', 1, 1, 'required|regex:/^([\\w\\d._-]+)(\\.jar)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(3, 2, 'Server Jar File', 'The name of the Jarfile to use when running Forge Mod.', 'SERVER_JARFILE', 'server.jar', 1, 1, 'required|regex:/^([\\w\\d._-]+)(\\.jar)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(4, 2, 'Forge version', 'The version of minecraft you want to install for.\r\n\r\nLeaving latest will install the latest recommended version.', 'MC_VERSION', 'latest', 1, 1, 'required|string|max:9', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(5, 2, 'Build Type', 'The type of server jar to download from forge.\r\n\r\nValid types are \"recommended\" and \"latest\".', 'BUILD_TYPE', 'recommended', 1, 1, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(6, 2, 'Forge Version', 'Gets an exact version.\r\n\r\nEx. 1.15.2-31.2.4\r\n\r\nOverrides MC_VERSION and BUILD_TYPE. If it fails to download the server files it will fail to install.', 'FORGE_VERSION', '', 1, 1, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(7, 3, 'Minecraft Version', 'The version of minecraft to download. \r\n\r\nLeave at latest to always get the latest version. Invalid versions will default to latest.', 'MINECRAFT_VERSION', 'latest', 1, 0, 'nullable|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(8, 3, 'Server Jar File', 'The name of the server jarfile to run the server with.', 'SERVER_JARFILE', 'server.jar', 1, 1, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(9, 3, 'Download Path', 'A URL to use to download a server.jar rather than the ones in the install script. This is not user viewable.', 'DL_PATH', '', 0, 0, 'nullable|string', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(10, 3, 'Build Number', 'The build number for the paper release.\r\n\r\nLeave at latest to always get the latest version. Invalid versions will default to latest.', 'BUILD_NUMBER', 'latest', 1, 0, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(11, 4, 'Sponge Version', 'The version of SpongeVanilla to download and use.', 'SPONGE_VERSION', '1.11.2-6.1.0-BETA-21', 1, 0, 'required|regex:/^([a-zA-Z0-9.\\-_]+)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(12, 4, 'Server Jar File', 'The name of the Jarfile to use when running SpongeVanilla.', 'SERVER_JARFILE', 'server.jar', 1, 1, 'required|regex:/^([\\w\\d._-]+)(\\.jar)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(13, 5, 'Server Jar File', 'The name of the server jarfile to run the server with.', 'SERVER_JARFILE', 'server.jar', 1, 1, 'required|regex:/^([\\w\\d._-]+)(\\.jar)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(14, 5, 'Server Version', 'The version of Minecraft Vanilla to install. Use \"latest\" to install the latest version.', 'VANILLA_VERSION', 'latest', 1, 1, 'required|string|between:3,15', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(15, 6, 'Server Name', 'ARK server name', 'SESSION_NAME', 'ARK SERVER', 1, 1, 'required|string|max:128', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(16, 6, 'Server Password', 'If specified, players must provide this password to join the server.', 'ARK_PASSWORD', '', 1, 1, 'nullable|alpha_dash|between:1,100', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(17, 6, 'Admin Password', 'If specified, players must provide this password (via the in-game console) to gain access to administrator commands on the server.', 'ARK_ADMIN_PASSWORD', '', 1, 1, 'nullable|alpha_dash|between:1,100', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(18, 6, 'Server Port', 'ARK server port used by client.', 'PORT', '7777', 1, 1, 'required|numeric', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(19, 6, 'Use Rcon', 'Enable or disable rcon system. (true or false)', 'ENABLE_RCON', 'false', 1, 1, 'required|string|max:5', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(20, 6, 'Rcon Port', 'ARK rcon port used by rcon tools.', 'RCON_PORT', '27020', 1, 1, 'required|numeric', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(21, 6, 'Query Port', 'ARK query port used by steam server browser and ark client server browser.', 'QUERY_PORT', '27015', 1, 1, 'required|numeric', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(22, 6, 'Maximum Players', 'Specifies the maximum number of players that can play on the server simultaneously.', 'SERVER_MAX_PLAYERS', '20', 1, 1, 'required|numeric|digits_between:1,4', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(23, 6, 'App ID', 'ARK steam app id for auto updates. Leave blank to avoid auto update.', 'SRCDS_APPID', '376030', 1, 0, 'nullable|numeric', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(24, 6, 'Server Map', 'Available Maps: TheIsland, TheCenter, Ragnarok, ScorchedEarth_P, Aberration_P, Extinction', 'SERVER_MAP', 'TheIsland', 1, 1, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(25, 7, 'Map', 'The default map for the server.', 'SRCDS_MAP', 'de_dust2', 1, 1, 'required|string|alpha_dash', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(26, 7, 'Steam Account Token', 'The Steam Account Token required for the server to be displayed publicly.', 'STEAM_ACC', '', 1, 1, 'required|string|alpha_num|size:32', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(27, 7, 'Source AppID', 'Required for game to update on server restart. Do not modify this.', 'SRCDS_APPID', '740', 0, 0, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(28, 8, 'Game ID', 'The ID corresponding to the game to download and run using SRCDS.', 'SRCDS_APPID', '', 1, 0, 'required|numeric|digits_between:1,6', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(29, 8, 'Game Name', 'The name corresponding to the game to download and run using SRCDS.', 'SRCDS_GAME', '', 1, 0, 'required|alpha_dash|between:1,100', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(30, 8, 'Map', 'The default map for the server.', 'SRCDS_MAP', '', 1, 1, 'required|string|alpha_dash', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(31, 9, 'Map', 'The default map for the server.', 'SRCDS_MAP', 'gm_flatgrass', 1, 1, 'required|string|alpha_dash', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(32, 9, 'Steam Account Token', 'The Steam Account Token required for the server to be displayed publicly.', 'STEAM_ACC', '', 1, 1, 'nullable|string|alpha_num|size:32', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(33, 9, 'Source AppID', 'Required for game to update on server restart. Do not modify this.', 'SRCDS_APPID', '4020', 0, 0, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(34, 9, 'Workshop ID', 'The ID of your workshop collection (the numbers at the end of the URL)', 'WORKSHOP_ID', '', 1, 1, 'nullable|integer', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(35, 9, 'Gamemode', 'The gamemode of your server.', 'GAMEMODE', 'sandbox', 1, 1, 'required|string', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(36, 9, 'Max Players', 'The maximum amount of players allowed on your game server.', 'MAX_PLAYERS', '32', 1, 1, 'required|integer|max:128', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(37, 9, 'Tickrate', 'The tickrate defines how fast the server will update each entities location.', 'TICKRATE', '22', 1, 1, 'required|integer|max:100', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(38, 10, 'Game ID', 'The ID corresponding to the game to download and run using SRCDS.', 'SRCDS_APPID', '237410', 1, 0, 'required|regex:/^(237410)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(39, 10, 'Game Name', 'The name corresponding to the game to download and run using SRCDS.', 'SRCDS_GAME', 'insurgency', 1, 0, 'required|regex:/^(insurgency)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(40, 10, 'Default Map', 'The default map to use when starting the server.', 'SRCDS_MAP', 'sinjar', 1, 1, 'required|regex:/^(\\w{1,20})$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(41, 11, 'Game ID', 'The ID corresponding to the game to download and run using SRCDS.', 'SRCDS_APPID', '232250', 1, 0, 'required|regex:/^(232250)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(42, 11, 'Game Name', 'The name corresponding to the game to download and run using SRCDS.', 'SRCDS_GAME', 'tf', 1, 0, 'required|regex:/^(tf)$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(43, 11, 'Default Map', 'The default map to use when starting the server.', 'SRCDS_MAP', 'cp_dustbowl', 1, 1, 'required|regex:/^(\\w{1,20})$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(44, 12, 'Maximum Users', 'Maximum concurrent users on the mumble server.', 'MAX_USERS', '100', 1, 0, 'required|numeric|digits_between:1,5', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(45, 12, 'Server Version', 'Version of Mumble Server to download and use.', 'MUMBLE_VERSION', '1.3.1', 1, 1, 'required|regex:/^([0-9_\\.-]{5,8})$/', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(46, 13, 'Server Version', 'The version of Teamspeak 3 to use when running the server.', 'TS_VERSION', 'latest', 1, 1, 'required|string|max:6', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(47, 13, 'File Transfer Port', 'The Teamspeak file transfer port', 'FILE_TRANSFER', '30033', 1, 0, 'required|integer|between:1,65535', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(48, 14, 'Server Name', 'The name of your server in the public server list.', 'HOSTNAME', 'A Rust Server', 1, 1, 'required|string|max:40', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(49, 14, 'OxideMod', 'Set whether you want the server to use and auto update OxideMod or not. Valid options are \"1\" for true and \"0\" for false.', 'OXIDE', '0', 1, 1, 'required|boolean', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(50, 14, 'Level', 'The world file for Rust to use.', 'LEVEL', 'Procedural Map', 1, 1, 'required|string|max:20', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(51, 14, 'Description', 'The description under your server title. Commonly used for rules & info. Use \\n for newlines.', 'DESCRIPTION', 'Powered by Pterodactyl', 1, 1, 'required|string', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(52, 14, 'URL', 'The URL for your server. This is what comes up when clicking the \"Visit Website\" button.', 'SERVER_URL', 'http://pterodactyl.io', 1, 1, 'nullable|url', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(53, 14, 'World Size', 'The world size for a procedural map.', 'WORLD_SIZE', '3000', 1, 1, 'required|integer', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(54, 14, 'World Seed', 'The seed for a procedural map.', 'WORLD_SEED', '', 1, 1, 'nullable|string', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(55, 14, 'Max Players', 'The maximum amount of players allowed in the server at once.', 'MAX_PLAYERS', '40', 1, 1, 'required|integer', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(56, 14, 'Server Image', 'The header image for the top of your server listing.', 'SERVER_IMG', '', 1, 1, 'nullable|url', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(57, 14, 'RCON Port', 'Port for RCON connections.', 'RCON_PORT', '28016', 1, 0, 'required|integer', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(58, 14, 'RCON Password', 'RCON access password.', 'RCON_PASS', 'CHANGEME', 1, 1, 'required|string|max:64', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(59, 14, 'Save Interval', 'Sets the server’s auto-save interval in seconds.', 'SAVEINTERVAL', '60', 1, 1, 'required|integer', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(60, 14, 'Additional Arguments', 'Add additional startup parameters to the server.', 'ADDITIONAL_ARGS', '', 1, 1, 'nullable|string', '2020-09-17 23:37:42', '2020-09-17 23:37:42');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` int(10) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL,
  `exception` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `connection`, `queue`, `payload`, `failed_at`, `exception`) VALUES
(1, 'database', 'standard', '{\"uuid\":\"98ee7edf-c986-4d66-ac08-3fb91d2c6ded\",\"displayName\":\"Pterodactyl\\\\Notifications\\\\AccountCreated\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"delay\":null,\"timeout\":null,\"timeoutAt\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":13:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:23:\\\"Pterodactyl\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:12:\\\"notification\\\";O:40:\\\"Pterodactyl\\\\Notifications\\\\AccountCreated\\\":11:{s:5:\\\"token\\\";N;s:4:\\\"user\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":4:{s:5:\\\"class\\\";s:23:\\\"Pterodactyl\\\\Models\\\\User\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";}s:2:\\\"id\\\";s:36:\\\"b92f3e74-befb-4b31-b32e-c7b39736978b\\\";s:6:\\\"locale\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:5:\\\"delay\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', '2020-09-17 23:39:46', 'Swift_TransportException: Cannot send message without a sender address in /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/AbstractSmtpTransport.php:195\nStack trace:\n#0 /app/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Mailer.php(71): Swift_Transport_AbstractSmtpTransport->send(Object(Swift_Message), Array)\n#1 /app/vendor/laravel/framework/src/Illuminate/Mail/Mailer.php(521): Swift_Mailer->send(Object(Swift_Message), Array)\n#2 /app/vendor/laravel/framework/src/Illuminate/Mail/Mailer.php(288): Illuminate\\Mail\\Mailer->sendSwiftMessage(Object(Swift_Message))\n#3 /app/vendor/laravel/framework/src/Illuminate/Notifications/Channels/MailChannel.php(65): Illuminate\\Mail\\Mailer->send(Object(Illuminate\\Support\\HtmlString), Array, Object(Closure))\n#4 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(146): Illuminate\\Notifications\\Channels\\MailChannel->send(Object(Pterodactyl\\Models\\User), Object(Pterodactyl\\Notifications\\AccountCreated))\n#5 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(105): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(Pterodactyl\\Models\\User), \'9dc2880b-cbb0-4...\', Object(Pterodactyl\\Notifications\\AccountCreated), \'mail\')\n#6 /app/vendor/laravel/framework/src/Illuminate/Support/Traits/Localizable.php(19): Illuminate\\Notifications\\NotificationSender->Illuminate\\Notifications\\{closure}()\n#7 /app/vendor/laravel/framework/src/Illuminate/Notifications/NotificationSender.php(107): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#8 /app/vendor/laravel/framework/src/Illuminate/Notifications/ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Pterodactyl\\Notifications\\AccountCreated), Array)\n#9 /app/vendor/laravel/framework/src/Illuminate/Notifications/SendQueuedNotifications.php(94): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Database\\Eloquent\\Collection), Object(Pterodactyl\\Notifications\\AccountCreated), Array)\n#10 [internal function]: Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#11 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(33): call_user_func_array(Array, Array)\n#12 /app/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#13 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(91): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#14 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#15 /app/vendor/laravel/framework/src/Illuminate/Container/Container.php(592): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#16 /app/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(94): Illuminate\\Container\\Container->call(Array)\n#17 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#18 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#19 /app/vendor/laravel/framework/src/Illuminate/Bus/Dispatcher.php(98): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(83): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#21 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#22 /app/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#23 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(85): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#24 /app/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(59): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 /app/vendor/laravel/framework/src/Illuminate/Queue/Jobs/Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#26 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(356): Illuminate\\Queue\\Jobs\\Job->fire()\n#27 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(306): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#28 /app/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(132): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#29 /app/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(112): Illuminate\\Queue\\Worker->daemon(\'database\', \'high,standard,l...\', Object(Illuminate\\Queue\\WorkerOptions))\n#30 /app/vendor/laravel/framework/src/Illuminate/Queue/Console/WorkCommand.php(96): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'high,standard,l...\')\n#31 [internal function]: Illuminate\\Queue\\Console\\WorkCommand->handle()\n#32 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(33): call_user_func_array(Array, Array)\n#33 /app/vendor/laravel/framework/src/Illuminate/Container/Util.php(37): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#34 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(91): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#35 /app/vendor/laravel/framework/src/Illuminate/Container/BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#36 /app/vendor/laravel/framework/src/Illuminate/Container/Container.php(592): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#37 /app/vendor/laravel/framework/src/Illuminate/Console/Command.php(134): Illuminate\\Container\\Container->call(Array)\n#38 /app/vendor/symfony/console/Command/Command.php(258): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#39 /app/vendor/laravel/framework/src/Illuminate/Console/Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#40 /app/vendor/symfony/console/Application.php(911): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 /app/vendor/symfony/console/Application.php(264): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#42 /app/vendor/symfony/console/Application.php(140): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 /app/vendor/laravel/framework/src/Illuminate/Console/Application.php(93): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 /app/vendor/laravel/framework/src/Illuminate/Foundation/Console/Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 /app/artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 {main}');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `short` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `long` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `short`, `long`, `created_at`, `updated_at`) VALUES
(1, 'cork.ie', 'cork', '2020-09-18 16:00:06', '2020-09-18 16:00:06');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2016_01_23_195641_add_allocations_table', 1),
(2, '2016_01_23_195851_add_api_keys', 1),
(3, '2016_01_23_200044_add_api_permissions', 1),
(4, '2016_01_23_200159_add_downloads', 1),
(5, '2016_01_23_200421_create_failed_jobs_table', 1),
(6, '2016_01_23_200440_create_jobs_table', 1),
(7, '2016_01_23_200528_add_locations', 1),
(8, '2016_01_23_200648_add_nodes', 1),
(9, '2016_01_23_201433_add_password_resets', 1),
(10, '2016_01_23_201531_add_permissions', 1),
(11, '2016_01_23_201649_add_server_variables', 1),
(12, '2016_01_23_201748_add_servers', 1),
(13, '2016_01_23_202544_add_service_options', 1),
(14, '2016_01_23_202731_add_service_varibles', 1),
(15, '2016_01_23_202943_add_services', 1),
(16, '2016_01_23_203119_create_settings_table', 1),
(17, '2016_01_23_203150_add_subusers', 1),
(18, '2016_01_23_203159_add_users', 1),
(19, '2016_01_23_203947_create_sessions_table', 1),
(20, '2016_01_25_234418_rename_permissions_column', 1),
(21, '2016_02_07_172148_add_databases_tables', 1),
(22, '2016_02_07_181319_add_database_servers_table', 1),
(23, '2016_02_13_154306_add_service_option_default_startup', 1),
(24, '2016_02_20_155318_add_unique_service_field', 1),
(25, '2016_02_27_163411_add_tasks_table', 1),
(26, '2016_02_27_163447_add_tasks_log_table', 1),
(27, '2016_03_18_155649_add_nullable_field_lastrun', 1),
(28, '2016_08_30_212718_add_ip_alias', 1),
(29, '2016_08_30_213301_modify_ip_storage_method', 1),
(30, '2016_09_01_193520_add_suspension_for_servers', 1),
(31, '2016_09_01_211924_remove_active_column', 1),
(32, '2016_09_02_190647_add_sftp_password_storage', 1),
(33, '2016_09_04_171338_update_jobs_tables', 1),
(34, '2016_09_04_172028_update_failed_jobs_table', 1),
(35, '2016_09_04_182835_create_notifications_table', 1),
(36, '2016_09_07_163017_add_unique_identifier', 1),
(37, '2016_09_14_145945_allow_longer_regex_field', 1),
(38, '2016_09_17_194246_add_docker_image_column', 1),
(39, '2016_09_21_165554_update_servers_column_name', 1),
(40, '2016_09_29_213518_rename_double_insurgency', 1),
(41, '2016_10_07_152117_build_api_log_table', 1),
(42, '2016_10_14_164802_update_api_keys', 1),
(43, '2016_10_23_181719_update_misnamed_bungee', 1),
(44, '2016_10_23_193810_add_foreign_keys_servers', 1),
(45, '2016_10_23_201624_add_foreign_allocations', 1),
(46, '2016_10_23_202222_add_foreign_api_keys', 1),
(47, '2016_10_23_202703_add_foreign_api_permissions', 1),
(48, '2016_10_23_202953_add_foreign_database_servers', 1),
(49, '2016_10_23_203105_add_foreign_databases', 1),
(50, '2016_10_23_203335_add_foreign_nodes', 1),
(51, '2016_10_23_203522_add_foreign_permissions', 1),
(52, '2016_10_23_203857_add_foreign_server_variables', 1),
(53, '2016_10_23_204157_add_foreign_service_options', 1),
(54, '2016_10_23_204321_add_foreign_service_variables', 1),
(55, '2016_10_23_204454_add_foreign_subusers', 1),
(56, '2016_10_23_204610_add_foreign_tasks', 1),
(57, '2016_11_04_000949_add_ark_service_option_fixed', 1),
(58, '2016_11_11_220649_add_pack_support', 1),
(59, '2016_11_11_231731_set_service_name_unique', 1),
(60, '2016_11_27_142519_add_pack_column', 1),
(61, '2016_12_01_173018_add_configurable_upload_limit', 1),
(62, '2016_12_02_185206_correct_service_variables', 1),
(63, '2017_01_03_150436_fix_misnamed_option_tag', 1),
(64, '2017_01_07_154228_create_node_configuration_tokens_table', 1),
(65, '2017_01_12_135449_add_more_user_data', 1),
(66, '2017_02_02_175548_UpdateColumnNames', 1),
(67, '2017_02_03_140948_UpdateNodesTable', 1),
(68, '2017_02_03_155554_RenameColumns', 1),
(69, '2017_02_05_164123_AdjustColumnNames', 1),
(70, '2017_02_05_164516_AdjustColumnNamesForServicePacks', 1),
(71, '2017_02_09_174834_SetupPermissionsPivotTable', 1),
(72, '2017_02_10_171858_UpdateAPIKeyColumnNames', 1),
(73, '2017_03_03_224254_UpdateNodeConfigTokensColumns', 1),
(74, '2017_03_05_212803_DeleteServiceExecutableOption', 1),
(75, '2017_03_10_162934_AddNewServiceOptionsColumns', 1),
(76, '2017_03_10_173607_MigrateToNewServiceSystem', 1),
(77, '2017_03_11_215455_ChangeServiceVariablesValidationRules', 1),
(78, '2017_03_12_150648_MoveFunctionsFromFileToDatabase', 1),
(79, '2017_03_14_175631_RenameServicePacksToSingluarPacks', 1),
(80, '2017_03_14_200326_AddLockedStatusToTable', 1),
(81, '2017_03_16_181109_ReOrganizeDatabaseServersToDatabaseHost', 1),
(82, '2017_03_16_181515_CleanupDatabasesDatabase', 1),
(83, '2017_03_18_204953_AddForeignKeyToPacks', 1),
(84, '2017_03_31_221948_AddServerDescriptionColumn', 1),
(85, '2017_04_02_163232_DropDeletedAtColumnFromServers', 1),
(86, '2017_04_15_125021_UpgradeTaskSystem', 1),
(87, '2017_04_20_171943_AddScriptsToServiceOptions', 1),
(88, '2017_04_21_151432_AddServiceScriptTrackingToServers', 1),
(89, '2017_04_27_145300_AddCopyScriptFromColumn', 1),
(90, '2017_04_27_223629_AddAbilityToDefineConnectionOverSSLWithDaemonBehindProxy', 1),
(91, '2017_05_01_141528_DeleteDownloadTable', 1),
(92, '2017_05_01_141559_DeleteNodeConfigurationTable', 1),
(93, '2017_06_10_152951_add_external_id_to_users', 1),
(94, '2017_06_25_133923_ChangeForeignKeyToBeOnCascadeDelete', 1),
(95, '2017_07_08_152806_ChangeUserPermissionsToDeleteOnUserDeletion', 1),
(96, '2017_07_08_154416_SetAllocationToReferenceNullOnServerDelete', 1),
(97, '2017_07_08_154650_CascadeDeletionWhenAServerOrVariableIsDeleted', 1),
(98, '2017_07_24_194433_DeleteTaskWhenParentServerIsDeleted', 1),
(99, '2017_08_05_115800_CascadeNullValuesForDatabaseHostWhenNodeIsDeleted', 1),
(100, '2017_08_05_144104_AllowNegativeValuesForOverallocation', 1),
(101, '2017_08_05_174811_SetAllocationUnqiueUsingMultipleFields', 1),
(102, '2017_08_15_214555_CascadeDeletionWhenAParentServiceIsDeleted', 1),
(103, '2017_08_18_215428_RemovePackWhenParentServiceOptionIsDeleted', 1),
(104, '2017_09_10_225749_RenameTasksTableForStructureRefactor', 1),
(105, '2017_09_10_225941_CreateSchedulesTable', 1),
(106, '2017_09_10_230309_CreateNewTasksTableForSchedules', 1),
(107, '2017_09_11_002938_TransferOldTasksToNewScheduler', 1),
(108, '2017_09_13_211810_UpdateOldPermissionsToPointToNewScheduleSystem', 1),
(109, '2017_09_23_170933_CreateDaemonKeysTable', 1),
(110, '2017_09_23_173628_RemoveDaemonSecretFromServersTable', 1),
(111, '2017_09_23_185022_RemoveDaemonSecretFromSubusersTable', 1),
(112, '2017_10_02_202000_ChangeServicesToUseAMoreUniqueIdentifier', 1),
(113, '2017_10_02_202007_ChangeToABetterUniqueServiceConfiguration', 1),
(114, '2017_10_03_233202_CascadeDeletionWhenServiceOptionIsDeleted', 1),
(115, '2017_10_06_214026_ServicesToNestsConversion', 1),
(116, '2017_10_06_214053_ServiceOptionsToEggsConversion', 1),
(117, '2017_10_06_215741_ServiceVariablesToEggVariablesConversion', 1),
(118, '2017_10_24_222238_RemoveLegacySFTPInformation', 1),
(119, '2017_11_11_161922_Add2FaLastAuthorizationTimeColumn', 1),
(120, '2017_11_19_122708_MigratePubPrivFormatToSingleKey', 1),
(121, '2017_12_04_184012_DropAllocationsWhenNodeIsDeleted', 1),
(122, '2017_12_12_220426_MigrateSettingsTableToNewFormat', 1),
(123, '2018_01_01_122821_AllowNegativeValuesForServerSwap', 1),
(124, '2018_01_11_213943_AddApiKeyPermissionColumns', 1),
(125, '2018_01_13_142012_SetupTableForKeyEncryption', 1),
(126, '2018_01_13_145209_AddLastUsedAtColumn', 1),
(127, '2018_02_04_145617_AllowTextInUserExternalId', 1),
(128, '2018_02_10_151150_remove_unique_index_on_external_id_column', 1),
(129, '2018_02_17_134254_ensure_unique_allocation_id_on_servers_table', 1),
(130, '2018_02_24_112356_add_external_id_column_to_servers_table', 1),
(131, '2018_02_25_160152_remove_default_null_value_on_table', 1),
(132, '2018_02_25_160604_define_unique_index_on_users_external_id', 1),
(133, '2018_03_01_192831_add_database_and_port_limit_columns_to_servers_table', 1),
(134, '2018_03_15_124536_add_description_to_nodes', 1),
(135, '2018_05_04_123826_add_maintenance_to_nodes', 1),
(136, '2018_09_03_143756_allow_egg_variables_to_have_longer_values', 1),
(137, '2018_09_03_144005_allow_server_variables_to_have_longer_values', 1),
(138, '2019_03_02_142328_set_allocation_limit_default_null', 1),
(139, '2019_03_02_151321_fix_unique_index_to_account_for_host', 1),
(140, '2020_03_22_163911_merge_permissions_table_into_subusers', 1),
(141, '2020_03_22_164814_drop_permissions_table', 1),
(142, '2020_04_03_203624_add_threads_column_to_servers_table', 1),
(143, '2020_04_03_230614_create_backups_table', 1),
(144, '2020_04_04_131016_add_table_server_transfers', 1),
(145, '2020_04_10_141024_store_node_tokens_as_encrypted_value', 1),
(146, '2020_04_17_203438_allow_nullable_descriptions', 1),
(147, '2020_04_22_055500_add_max_connections_column', 1),
(148, '2020_04_26_111208_add_backup_limit_to_servers', 1),
(149, '2020_05_20_234655_add_mounts_table', 1),
(150, '2020_05_21_192756_add_mount_server_table', 1),
(151, '2020_07_02_213612_create_user_recovery_tokens_table', 1),
(152, '2020_07_09_201845_add_notes_column_for_allocations', 1),
(153, '2020_08_20_205533_add_backup_state_column_to_backups', 1),
(154, '2020_08_22_132500_update_bytes_to_unsigned_bigint', 1),
(155, '2020_08_23_175331_modify_checksums_column_for_backups', 1),
(156, '2020_09_13_110007_drop_packs_from_servers', 1),
(157, '2020_09_13_110021_drop_packs_from_api_key_permissions', 1),
(158, '2020_09_13_110047_drop_packs_table', 1),
(159, '2020_09_13_113503_drop_daemon_key_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mounts`
--

CREATE TABLE `mounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `source` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_only` tinyint(3) UNSIGNED NOT NULL,
  `user_mountable` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mount_node`
--

CREATE TABLE `mount_node` (
  `node_id` int(11) NOT NULL,
  `mount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mount_server`
--

CREATE TABLE `mount_server` (
  `server_id` int(11) NOT NULL,
  `mount_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nests`
--

CREATE TABLE `nests` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` char(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nests`
--

INSERT INTO `nests` (`id`, `uuid`, `author`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, '1bd59a12-ad53-4cb0-9a62-00f56f9cb2e7', 'support@pterodactyl.io', 'Minecraft', 'Minecraft - the classic game from Mojang. With support for Vanilla MC, Spigot, and many others!', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(2, 'a792420e-9e27-4130-84c0-6ed243e6626a', 'support@pterodactyl.io', 'Source Engine', 'Includes support for most Source Dedicated Server games.', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(3, 'c10ea164-85bf-4f11-890a-4135d324f6e6', 'support@pterodactyl.io', 'Voice Servers', 'Voice servers such as Mumble and Teamspeak 3.', '2020-09-17 23:37:42', '2020-09-17 23:37:42'),
(4, '3bd5d409-5e57-4652-a4b0-3cf1cca46e91', 'support@pterodactyl.io', 'Rust', 'Rust - A game where you must fight to survive.', '2020-09-17 23:37:42', '2020-09-17 23:37:42');

-- --------------------------------------------------------

--
-- Table structure for table `nodes`
--

CREATE TABLE `nodes` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `location_id` int(10) UNSIGNED NOT NULL,
  `fqdn` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `scheme` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'https',
  `behind_proxy` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `memory` int(10) UNSIGNED NOT NULL,
  `memory_overallocate` int(11) NOT NULL DEFAULT '0',
  `disk` int(10) UNSIGNED NOT NULL,
  `disk_overallocate` int(11) NOT NULL DEFAULT '0',
  `upload_size` int(10) UNSIGNED NOT NULL DEFAULT '100',
  `daemon_token_id` char(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `daemon_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `daemonListen` smallint(5) UNSIGNED NOT NULL DEFAULT '8080',
  `daemonSFTP` smallint(6) NOT NULL DEFAULT '2022',
  `daemonBase` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '/home/daemon-files',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nodes`
--

INSERT INTO `nodes` (`id`, `uuid`, `public`, `name`, `description`, `location_id`, `fqdn`, `scheme`, `behind_proxy`, `maintenance_mode`, `memory`, `memory_overallocate`, `disk`, `disk_overallocate`, `upload_size`, `daemon_token_id`, `daemon_token`, `daemonListen`, `daemonSFTP`, `daemonBase`, `created_at`, `updated_at`) VALUES
(1, '2619c456-1526-4c58-95a1-66fe3bc75af7', 1, 'test', 'test', 1, 'games-daemon.netsoc.local', 'http', 0, 0, 100, 100, 100, 100, 100, 'F99ENnPSLTlVdKvD', 'eyJpdiI6ImttSS90S0RadUM3akdqaTRIQi9VeEE9PSIsInZhbHVlIjoiZTFQQWpEdEM4OHlZZ1N2RXQzZXBITFdFNkNYd0ovaHVVUkVIcVZrQWR5ejZ4WHk4VGpKTG9KOUZFcWsrZ01nSGhXYkZkd2lCcXg3ckRHUWZkSXhoVVdxZW83VlFGWUFLeWpSOHpTenR3WnM9IiwibWFjIjoiNGVhMjE5MzEyNGMwYzUwNjIwMTgyYzFlZTJiZTYzMGRmNTU1Nzg3YzEyMmUxZTM1NDFlZWUwNjczOTgwYjllMCJ9', 8080, 2022, '/var/lib/pterodactyl/volumes', '2020-09-18 16:01:17', '2020-09-18 16:01:17');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recovery_tokens`
--

CREATE TABLE `recovery_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cron_day_of_week` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cron_day_of_month` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cron_hour` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cron_minute` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_processing` tinyint(1) NOT NULL,
  `last_run_at` timestamp NULL DEFAULT NULL,
  `next_run_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `servers`
--

CREATE TABLE `servers` (
  `id` int(10) UNSIGNED NOT NULL,
  `external_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuidShort` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `node_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `skip_scripts` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `owner_id` int(10) UNSIGNED NOT NULL,
  `memory` int(10) UNSIGNED NOT NULL,
  `swap` int(11) NOT NULL,
  `disk` int(10) UNSIGNED NOT NULL,
  `io` int(10) UNSIGNED NOT NULL,
  `cpu` int(10) UNSIGNED NOT NULL,
  `threads` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oom_disabled` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `allocation_id` int(10) UNSIGNED NOT NULL,
  `nest_id` int(10) UNSIGNED NOT NULL,
  `egg_id` int(10) UNSIGNED NOT NULL,
  `startup` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `installed` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `allocation_limit` int(10) UNSIGNED DEFAULT NULL,
  `database_limit` int(10) UNSIGNED DEFAULT '0',
  `backup_limit` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `servers`
--

INSERT INTO `servers` (`id`, `external_id`, `uuid`, `uuidShort`, `node_id`, `name`, `description`, `skip_scripts`, `suspended`, `owner_id`, `memory`, `swap`, `disk`, `io`, `cpu`, `threads`, `oom_disabled`, `allocation_id`, `nest_id`, `egg_id`, `startup`, `image`, `installed`, `allocation_limit`, `database_limit`, `backup_limit`, `created_at`, `updated_at`) VALUES
(1, NULL, '5f336a0a-f78b-43d5-a212-f182861d775c', '5f336a0a', 1, 'Test', 'test', 0, 0, 1, 100, 0, 100, 500, 100, '6', 1, 1, 1, 1, 'java -Xms128M -Xmx{{SERVER_MEMORY}}M -jar {{SERVER_JARFILE}}', 'quay.io/pterodactyl/core:java', 1, 0, 0, 0, '2020-09-18 16:05:11', '2020-09-18 16:06:08');

-- --------------------------------------------------------

--
-- Table structure for table `server_transfers`
--

CREATE TABLE `server_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `successful` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `old_node` int(10) UNSIGNED NOT NULL,
  `new_node` int(10) UNSIGNED NOT NULL,
  `old_allocation` int(10) UNSIGNED NOT NULL,
  `new_allocation` int(10) UNSIGNED NOT NULL,
  `old_additional_allocations` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `new_additional_allocations` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `server_variables`
--

CREATE TABLE `server_variables` (
  `id` int(10) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED DEFAULT NULL,
  `variable_id` int(10) UNSIGNED NOT NULL,
  `variable_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `server_variables`
--

INSERT INTO `server_variables` (`id`, `server_id`, `variable_id`, `variable_value`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'latest', NULL, NULL),
(2, 1, 2, 'bungeecord.jar', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('3UwBrWNUCfZi9qcewgqa6tek4G9HIVcfZ7ao2Pm3', 1, '172.24.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36', 'ZXlKcGRpSTZJbmd6UTBRNWNHUkNhR3RCTjA1WWNXTkNiWEIyYmxFOVBTSXNJblpoYkhWbElqb2lUWHBDWmxKRVlqTlNNbkV5UVVZMlNHWlZlVTh3Y2xWQ1UyTkNiM0kwVUVGNWJEbHhTMjgxTDJFME4xaG5XVlZPUVVGSFFubHVTSEZ0WkVkV2RtRXpXamhTUm04dk5DOVFSbWQ0U0dKck0yOVRaMUpPYTJneFVYVXdSVGc0Ukd0c2ExazJhM1ZwUVdVeFYyWjZhblk1Tm1kMlJqQjRURzlQVm5CMWRHOXhXRTFsU0V4TU5GZ3dlR3RESzFoRFkxVldUR2h0WTBObmRIQXplbVZtWjFsTll6Y3JVVTFRVm5ZclVUZHlVSGcwVW5STFdVcFRaVFZwVG0xTlMwMWxMMWMyUXpSNFNYTXJibGR4V214NU4xRlphbmxqVkRScGJtZzBRVGRGUTB4VWNuRjRXVmswV2toWVNWa3ZWa2RPV1djM2NYQkRaREJJZUdOclZVMU5UV2gzVm1OblYzQTNXSEJTVldaVFpDdDZXVmxJYmpncmFsTkpaRkZUU0VKNWQxWmpVa2xyY0RSdmJqWlBia2xyTmprNFRuWk1kR2hvWW1oTE5FTm5iemx1ZDBOV1VHZDFlblpGTjBkWWQyZ3piVVV4VHpsYU1HMUVMMHBoWmsxVmVGZEdlV0U1T1ZJemVXTXlOM1UwVG10VWFXMHZZbTlpVmt4WE5YVXJSMWhHUlRkelFWRkxia2RNWVVaU1NsaDFlR2d3VFdaSGVEZGthMUp4V1ZKTmJFdG5ibTFEVjA5YU0wVm9Ubmt3YmpGNk1VaG5la2hZWmtwV1QxVm5kVm80VW01dVNsVk9aRzUyVWpocmNVTjRUV2x0U1dFMlRtRkZObVUyUm5kYWEwaE5WRzB4ZGs1U2NYZGphSFJSVXpnOUlpd2liV0ZqSWpvaVlXUXlNakExT0RreU5qbGpaalV3TnprelpqUmxOall3WTJNMU1XWTRPVE0xTnpFeU56WmpabUZpTkRRd1l6QXpOekF6T1dRMU56RTBabUZoWkRCa1lpSjk=', 1600445111),
('yDiEmskOkMPoyVH3uqbULXmh1UORIDBOQMa2sxHH', 1, '172.24.0.5', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36', 'ZXlKcGRpSTZJbUphTUVrMFNsRXpkV3hPWmpKRVRTczVUbHBqWWtFOVBTSXNJblpoYkhWbElqb2lUM1ppV1ZrcmRIRjRNRkJQVjFCQ2EwUlpRME5LU1VVMkwwWkNUMmxLZUN0UEt6SmhRelJDYTJwRVRXY3lSR2RLYWtSa1FtVjRRalZ3VGt4WVIxbzBWRzgwUnpOR05XNXdhVzl1Y0VsaGVuVjZNV05LU3pSUlNHaEhlazlEVkZjemJqQjRRVk5pZVN0VU1XaE5ObmcwYUhsUVJIRjNTUzh2UWxGWU16TlJNbmxvTkZsM09VbE1XRmx6UlhSQ1drRllNWGxHYWs5VGVFNDBkRFk1TXpKVlVXeE5aRGwwVjFaM01XMXNVazByY1dGRVZ6bHVVa0pEZVROWVZtWm5SMlpSZFZwNVIxcHNla2xJUzI5Q1RVMDRVVWN2YzJ0b09HTnNOVVZoUkV4RGIyUjVNQzltTlZkT2RqSldlR3R6TW5ZeFJ6RjFOVmxPTDNoS2JrTnZRa1V6Y0ZreFlrMW9jVVJoWlRFME4ybHNTV1ZrVFZScEswWkphekYxU1doc04wRnpkMFJGYlhWM1ltTkRibE41TmpGVGIwNTRSMU5NVUZCdWNsQmhZa3BUYWsxdGVXSjFXamd6V2lzNVVHSlpUV2RxTlROT2RqVTRXR05HUTNsbmJHaGxkVGhqV25sTFZIRnljMDFXUW1abVZtUlRaMFUwT0cweFNEZHFjakUxZEhGSlJFWk1lVWxZWm5sNWNUVm5Za05KYkdnMWNUbFJaa1F3Tm5OTkwya3ZRVTVRZFhWNlExUllRMlJqZFRWb2JuQXhRbFZxSzJKa1RteElWVzVQUkhFNGJHbEZXako1Y0VabE5rWjJRVE50VEhOTGVubzVUVXd5TXl0RE4wcGpRa0ZUT1ZKTlpuSldOamxUVFdSd2FYTnJVM3BCVkRWTEsxRnZaMWh6UzA1T2FrdFZObEpoYWt0dGEzQllSazg1YzI5WmMwTk9lV3BZUkZkb0t6SmhRbnBqZVcxMlpsZzRUVkJOYlU4NFBTSXNJbTFoWXlJNklqY3dNekppWW1WaU5XUm1OV1EzTXpsbU5XTTNOV1kyT0RjMVpqazNaR1F3TkRBd01XRmtOekkyTm1FMk56YzFZalU1WldGalpEQmlNR1U0TWpGaVlUWWlmUT09', 1600385988);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subusers`
--

CREATE TABLE `subusers` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `server_id` int(10) UNSIGNED NOT NULL,
  `permissions` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(10) UNSIGNED NOT NULL,
  `sequence_id` int(10) UNSIGNED NOT NULL,
  `action` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_offset` int(10) UNSIGNED NOT NULL,
  `is_queued` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tasks_log`
--

CREATE TABLE `tasks_log` (
  `id` int(10) UNSIGNED NOT NULL,
  `task_id` int(10) UNSIGNED NOT NULL,
  `run_time` timestamp NOT NULL,
  `run_status` int(10) UNSIGNED NOT NULL,
  `response` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `external_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_first` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_last` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` char(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `root_admin` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `use_totp` tinyint(3) UNSIGNED NOT NULL,
  `totp_secret` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `totp_authenticated_at` timestamp NULL DEFAULT NULL,
  `gravatar` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `external_id`, `uuid`, `username`, `email`, `name_first`, `name_last`, `password`, `remember_token`, `language`, `root_admin`, `use_totp`, `totp_secret`, `totp_authenticated_at`, `gravatar`, `created_at`, `updated_at`) VALUES
(1, NULL, '3240c106-44ff-4887-a9f6-072e32921a64', 'user', 'pterodactyl@user.com', 'T', 'T', '$2y$10$6994eqgYfD7kVWyGaCTMNuhItCKDf6z7inaKLoz.s9CPu9EK7wl7i', 'W5J87RHev8cuCAshBeQpF3yXSUufhfe7IZen4vABvtOFUeJeKX5FnHN4toPP', 'en', 1, 0, NULL, NULL, 1, '2020-09-17 23:39:37', '2020-09-17 23:39:37');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `allocations`
--
ALTER TABLE `allocations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `allocations_node_id_ip_port_unique` (`node_id`,`ip`,`port`),
  ADD KEY `allocations_server_id_foreign` (`server_id`);

--
-- Indexes for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_keys_identifier_unique` (`identifier`),
  ADD KEY `api_keys_user_id_foreign` (`user_id`);

--
-- Indexes for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `backups`
--
ALTER TABLE `backups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `backups_uuid_unique` (`uuid`),
  ADD KEY `backups_server_id_foreign` (`server_id`);

--
-- Indexes for table `databases`
--
ALTER TABLE `databases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `databases_database_host_id_database_unique` (`database_host_id`,`database`),
  ADD UNIQUE KEY `databases_database_host_id_username_unique` (`database_host_id`,`username`),
  ADD KEY `databases_server_id_foreign` (`server_id`);

--
-- Indexes for table `database_hosts`
--
ALTER TABLE `database_hosts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `database_hosts_node_id_foreign` (`node_id`);

--
-- Indexes for table `eggs`
--
ALTER TABLE `eggs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `service_options_uuid_unique` (`uuid`),
  ADD KEY `service_options_nest_id_foreign` (`nest_id`),
  ADD KEY `eggs_config_from_foreign` (`config_from`),
  ADD KEY `eggs_copy_script_from_foreign` (`copy_script_from`);

--
-- Indexes for table `egg_mount`
--
ALTER TABLE `egg_mount`
  ADD UNIQUE KEY `egg_mount_egg_id_mount_id_unique` (`egg_id`,`mount_id`);

--
-- Indexes for table `egg_variables`
--
ALTER TABLE `egg_variables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_variables_egg_id_foreign` (`egg_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `locations_short_unique` (`short`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mounts`
--
ALTER TABLE `mounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mounts_id_unique` (`id`),
  ADD UNIQUE KEY `mounts_uuid_unique` (`uuid`),
  ADD UNIQUE KEY `mounts_name_unique` (`name`);

--
-- Indexes for table `mount_node`
--
ALTER TABLE `mount_node`
  ADD UNIQUE KEY `mount_node_node_id_mount_id_unique` (`node_id`,`mount_id`);

--
-- Indexes for table `mount_server`
--
ALTER TABLE `mount_server`
  ADD UNIQUE KEY `mount_server_server_id_mount_id_unique` (`server_id`,`mount_id`);

--
-- Indexes for table `nests`
--
ALTER TABLE `nests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `services_uuid_unique` (`uuid`);

--
-- Indexes for table `nodes`
--
ALTER TABLE `nodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nodes_uuid_unique` (`uuid`),
  ADD UNIQUE KEY `nodes_daemon_token_id_unique` (`daemon_token_id`),
  ADD KEY `nodes_location_id_foreign` (`location_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `recovery_tokens`
--
ALTER TABLE `recovery_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recovery_tokens_user_id_foreign` (`user_id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schedules_server_id_foreign` (`server_id`);

--
-- Indexes for table `servers`
--
ALTER TABLE `servers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `servers_uuid_unique` (`uuid`),
  ADD UNIQUE KEY `servers_uuidshort_unique` (`uuidShort`),
  ADD UNIQUE KEY `servers_allocation_id_unique` (`allocation_id`),
  ADD UNIQUE KEY `servers_external_id_unique` (`external_id`),
  ADD KEY `servers_node_id_foreign` (`node_id`),
  ADD KEY `servers_owner_id_foreign` (`owner_id`),
  ADD KEY `servers_nest_id_foreign` (`nest_id`),
  ADD KEY `servers_egg_id_foreign` (`egg_id`);

--
-- Indexes for table `server_transfers`
--
ALTER TABLE `server_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `server_transfers_server_id_foreign` (`server_id`);

--
-- Indexes for table `server_variables`
--
ALTER TABLE `server_variables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `server_variables_server_id_foreign` (`server_id`),
  ADD KEY `server_variables_variable_id_foreign` (`variable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD UNIQUE KEY `sessions_id_unique` (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `subusers`
--
ALTER TABLE `subusers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subusers_user_id_foreign` (`user_id`),
  ADD KEY `subusers_server_id_foreign` (`server_id`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tasks_schedule_id_sequence_id_index` (`schedule_id`,`sequence_id`);

--
-- Indexes for table `tasks_log`
--
ALTER TABLE `tasks_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_uuid_unique` (`uuid`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD KEY `users_external_id_index` (`external_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `allocations`
--
ALTER TABLE `allocations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_keys`
--
ALTER TABLE `api_keys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_logs`
--
ALTER TABLE `api_logs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backups`
--
ALTER TABLE `backups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `databases`
--
ALTER TABLE `databases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `database_hosts`
--
ALTER TABLE `database_hosts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eggs`
--
ALTER TABLE `eggs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `egg_variables`
--
ALTER TABLE `egg_variables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT for table `mounts`
--
ALTER TABLE `mounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nests`
--
ALTER TABLE `nests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `nodes`
--
ALTER TABLE `nodes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `recovery_tokens`
--
ALTER TABLE `recovery_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `servers`
--
ALTER TABLE `servers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `server_transfers`
--
ALTER TABLE `server_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `server_variables`
--
ALTER TABLE `server_variables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subusers`
--
ALTER TABLE `subusers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tasks_log`
--
ALTER TABLE `tasks_log`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `allocations`
--
ALTER TABLE `allocations`
  ADD CONSTRAINT `allocations_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `allocations_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `api_keys`
--
ALTER TABLE `api_keys`
  ADD CONSTRAINT `api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `backups`
--
ALTER TABLE `backups`
  ADD CONSTRAINT `backups_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `databases`
--
ALTER TABLE `databases`
  ADD CONSTRAINT `databases_database_host_id_foreign` FOREIGN KEY (`database_host_id`) REFERENCES `database_hosts` (`id`),
  ADD CONSTRAINT `databases_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`);

--
-- Constraints for table `database_hosts`
--
ALTER TABLE `database_hosts`
  ADD CONSTRAINT `database_hosts_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `eggs`
--
ALTER TABLE `eggs`
  ADD CONSTRAINT `eggs_config_from_foreign` FOREIGN KEY (`config_from`) REFERENCES `eggs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `eggs_copy_script_from_foreign` FOREIGN KEY (`copy_script_from`) REFERENCES `eggs` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `service_options_nest_id_foreign` FOREIGN KEY (`nest_id`) REFERENCES `nests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `egg_variables`
--
ALTER TABLE `egg_variables`
  ADD CONSTRAINT `service_variables_egg_id_foreign` FOREIGN KEY (`egg_id`) REFERENCES `eggs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `nodes`
--
ALTER TABLE `nodes`
  ADD CONSTRAINT `nodes_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `recovery_tokens`
--
ALTER TABLE `recovery_tokens`
  ADD CONSTRAINT `recovery_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `servers`
--
ALTER TABLE `servers`
  ADD CONSTRAINT `servers_allocation_id_foreign` FOREIGN KEY (`allocation_id`) REFERENCES `allocations` (`id`),
  ADD CONSTRAINT `servers_egg_id_foreign` FOREIGN KEY (`egg_id`) REFERENCES `eggs` (`id`),
  ADD CONSTRAINT `servers_nest_id_foreign` FOREIGN KEY (`nest_id`) REFERENCES `nests` (`id`),
  ADD CONSTRAINT `servers_node_id_foreign` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`),
  ADD CONSTRAINT `servers_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `server_transfers`
--
ALTER TABLE `server_transfers`
  ADD CONSTRAINT `server_transfers_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `server_variables`
--
ALTER TABLE `server_variables`
  ADD CONSTRAINT `server_variables_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `server_variables_variable_id_foreign` FOREIGN KEY (`variable_id`) REFERENCES `egg_variables` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `subusers`
--
ALTER TABLE `subusers`
  ADD CONSTRAINT `subusers_server_id_foreign` FOREIGN KEY (`server_id`) REFERENCES `servers` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `subusers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_schedule_id_foreign` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
