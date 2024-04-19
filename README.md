# BurrowConnect Project
Contributors: Benjamin Pierce Souren Prakash, Atharva Nilapwar, Mackinley Morgan, Abhir Naik

**Video Link:**

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
Our user interface has been built out for three personas: Owners, Experience Providers, and Advertisers. Starting at the landing/login page, one can navigate to their personas respective pages, each tailored to the use cases of each. Owners can manage their properties as well as create booking and communicate with customers. Experience Providers can manage their bundle offerings, create and view advertisements, as well as manage experience bookings with customers. Advertisers can view valuable information on the platform, represented through their BurrowConnect liaison. Advertisers on the platform can also view dashboarded information on customer data and property data, as well as all advertisements they have posted on the website. 




