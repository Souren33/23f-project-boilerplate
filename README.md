# BurrowConnect Project
Team Members: Souren Prakash, Atharva Nilapwar, Benjamin Pierce, Mackinley Morgan, Abhir Naik

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

## Description of UI
- 3 personas: Advertiser, Experience Provider, and Owner


-------------
Project Repo (make sure it is public)
Update the ReadME file to describe your project, any information the user needs to build/start the containers (such as adding the secrets passwords files), etc.  Include each team member’s name somewhere in the README. 
We should be able to run docker compose up, and all services should start, sql files should be executed, etc. 
Appsmith Repo (make sure it is public).  Update the README with a description of your UI, any information the user needs to know to access it, etc. 
include 5-8  minute video recorded by your team
-------------------




