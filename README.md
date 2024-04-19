# BurrowConnect Project
Contributors: Benjamin Pierce Souren Prakash, Atharva Nilapwar, Mackinley Morgan, Abhir Naik

**Video Link:** https://youtu.be/NkcyQMjRQBI

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
2. A Python Flask container to implement a REST API
3. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
2. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
3. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
4. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
5. Build the images with `docker compose build`
6. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

**To open Appsmith, navigate to localhost:8080 in your browser**

## Description of our Project
Burrow Connect is an all-in-one vacation planning platform that offers a seamless and comprehensive experience for travelers, hosts, and local businesses. The platform enables travelers to search, compare, and book affordable accommodations and unique, localized experiences while providing hosts and experience providers with the tools they need to effectively manage their offerings, connect with customers, and grow their businesses. With a focus on personalization, communication, and collaboration, Burrow Connect aims to create a thriving ecosystem where travelers can discover and book authentic, memorable experiences, hosts can optimize their rental property performance, and local businesses can showcase their offerings to a targeted audience of travel enthusiasts. The platform also incorporates advertisers, ensuring that properties, products, and services are promoted to the right audience, ultimately fostering a vibrant and sustainable travel community.

Our specific app dives into the personas of Owners, Experience Providers, and Advertisers, as they all provide interactions from different angles with the travelers of BurrowConnect.




