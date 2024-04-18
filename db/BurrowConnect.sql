CREATE DATABASE IF NOT EXISTS BurrowConnect;

grant all privileges on BurrowConnect.* to 'webapp'@'%';
flush privileges;

USE BurrowConnect;

CREATE TABLE Owner
(
    ownerID    INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL,
    gender     VARCHAR(50),
    email      VARCHAR(255) NOT NULL,
    bio        text,
    age        INT
);

CREATE TABLE Traveler
(
    travelerID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL,
    gender     VARCHAR(50)  NOT NULL,
    age        INT          NOT NULL,
    email      VARCHAR(255) NOT NULL,
    bio        text
);

CREATE TABLE Property
(
    propertyID  INT PRIMARY KEY AUTO_INCREMENT,
    `address`     VARCHAR(255) NOT NULL,
    city        VARCHAR(100) NOT NULL,
    region      VARCHAR(50)  NOT NULL,
    country     VARCHAR(20)  NOT NULL,
    `type`        varchar(20)  NOT NULL,
    `description` text         NOT NULL,
    title       text         NOT NULL,
    price       int          NOT NULL,
    ownerID     int,


    FOREIGN KEY (ownerID) REFERENCES Owner (ownerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT


);

CREATE TABLE PropertyReview
(
    reviewID   INT PRIMARY KEY AUTO_INCREMENT,
    reviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,        
    content    VARCHAR(1000) NOT NULL,
    travelerID INT           NOT NULL,
    propertyID INT           NOT NULL,
    FOREIGN KEY (travelerID) REFERENCES Traveler (travelerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (propertyID) REFERENCES Property (propertyID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Stay_Messages
(
    messID     INT PRIMARY KEY AUTO_INCREMENT,
    content    TEXT NOT NULL,
    dateSent   DATETIME DEFAULT CURRENT_TIMESTAMP,
    travelerID INT,
    ownerID    INT  NOT NULL,
    FOREIGN KEY (ownerID) REFERENCES Owner (ownerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (travelerID) REFERENCES Traveler (travelerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Stay_At
(
    stayID     INT PRIMARY KEY AUTO_INCREMENT,
    startDate  DATE NOT NULL,
    endDate    DATE NOT NULL,
    travelerID INT,
    propertyID INT,
    FOREIGN KEY (travelerID) REFERENCES Traveler (travelerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (propertyID) REFERENCES Property (propertyID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE ExperienceProviders
(
    providerID  INT PRIMARY KEY AUTO_INCREMENT,
    companyName VARCHAR(500) UNIQUE,
    address     VARCHAR(250)  NOT NULL,
    city        VARCHAR(50)   NOT NULL,
    region      VARCHAR(50)   NOT NULL,
    country     VARCHAR(50)   NOT NULL,
    email       VARCHAR(50)   NOT NULL,
    description VARCHAR(2000) NOT NULL
);

CREATE TABLE Experience_Reviews
(
    reviewID   INT PRIMARY KEY AUTO_INCREMENT,
    content    VARCHAR(1000) NOT NULL,
    reviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    providerID INT,
    travelerID INT,
    FOREIGN KEY (providerID) REFERENCES ExperienceProviders (providerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (travelerID) REFERENCES Traveler (travelerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE AdLiaison
(
    liaisonID  INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name  VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL
);

CREATE TABLE Advertiser
(
    advertiserID INT PRIMARY KEY AUTO_INCREMENT,
    first_name   VARCHAR(255) NOT NULL,
    last_name    VARCHAR(255) NOT NULL,
    companyName  VARCHAR(500) NOT NULL,
    email        VARCHAR(255) NOT NULL,
    package      VARCHAR(50)  NOT NULL,
    liaisonID    INT,
    FOREIGN KEY (liaisonID) REFERENCES AdLiaison (liaisonID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Experience_Ads
(
    adID         INT PRIMARY KEY AUTO_INCREMENT,
    package      VARCHAR(50) NOT NULL,
    providerID   INT,
    advertiserID INT,
    FOREIGN KEY (providerID) REFERENCES ExperienceProviders (providerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (advertiserID) REFERENCES Advertiser (advertiserID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Travel_Data
(
    travelerID   INT,
    advertiserID INT,
    FOREIGN KEY (travelerID) REFERENCES Traveler (travelerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (advertiserID) REFERENCES Advertiser (advertiserID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    PRIMARY KEY (travelerID, advertiserID)
);

CREATE TABLE Property_Data
(
    advertiserID INT,
    propertyID   INT,
    FOREIGN KEY (advertiserID) REFERENCES Advertiser (advertiserID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (propertyID) REFERENCES Property (propertyID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    PRIMARY KEY (advertiserID, propertyID)
);

CREATE TABLE Bundle
(
    bundleID    INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(2000) NOT NULL,
    type        VARCHAR(100)  NOT NULL,
    title       VARCHAR(100)  NOT NULL,
    price       INT
);

CREATE TABLE Experience
(
    experienceID INT PRIMARY KEY AUTO_INCREMENT,
    date         DATE NOT NULL,
    bundleID     INT  NOT NULL,
    travelerID   INT,
    FOREIGN KEY (bundleID) REFERENCES Bundle (bundleID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (travelerID) REFERENCES Traveler (travelerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Offer
(
    bundleID   INT,
    providerID INT,
    FOREIGN KEY (bundleID) REFERENCES Bundle (bundleID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (providerID) REFERENCES ExperienceProviders (providerID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    PRIMARY KEY (bundleID, providerID)
);


-- Sample data for Owner table
INSERT INTO Owner (first_name, last_name, gender, email, bio, age)
VALUES ('Alice', 'Johnson', 'Female', 'alice.johnson@example.com',
        'Real estate agent specializing in luxury properties', 40),
       ('Robert', 'Miller', 'Male', 'robert.miller@example.com',
        'Property developer with a focus on sustainable housing', 45),
       ('Ella', 'Garcia', 'Female', 'ella.garcia@example.com',
        'Investor with a passion for restoring historic buildings', 55),
       ('James', 'Brown', 'Male', 'james.brown@example.com', 'Young entrepreneur venturing into property management',
        30),
       ('Sophie', 'Chen', 'Female', 'sophie.chen@example.com',
        'Experienced landlord managing multiple rental properties', 50);


-- Sample data for Traveler table
INSERT INTO Traveler (first_name, last_name, gender, age, email, bio)
VALUES ('Daniel', 'Wilson', 'Male', 28, 'daniel.wilson@example.com',
        'Frequent traveler exploring cultures and cuisines'),
       ('Grace', 'Lee', 'Female', 35, 'grace.lee@example.com', 'Solo traveler on a journey of self-discovery'),
       ('Matthew', 'Gonzalez', 'Male', 32, 'matthew.gonzalez@example.com',
        'Digital nomad working remotely while traveling'),
       ('Lily', 'Martinez', 'Female', 27, 'lily.martinez@example.com',
        'Adventure enthusiast seeking adrenaline-packed experiences'),
       ('Christopher', 'Hernandez', 'Male', 40, 'christopher.hernandez@example.com',
        'Family man planning memorable vacations with loved ones');


-- Sample data for Property table
INSERT INTO Property (address, city, region, country, type, description, title, price, ownerID)
VALUES ('101 Park Ave', 'Metropolis', 'Metroregion', 'USA', 'Apartment',
        'Luxurious penthouse with panoramic city views', 'Luxury Penthouse', 5000, 1),
       ('202 Beach Rd', 'Seaside', 'Coastalregion', 'USA', 'House',
        'Beachfront property with private access to the ocean', 'Seaside Retreat', 10000, 2),
       ('303 Mountain Dr', 'Mountainville', 'Mountainregion', 'USA', 'Cabin', 'Cozy cabin nestled in the mountains',
        'Mountain Cabin Getaway', 2500, 3),
       ('404 Lakeview Ln', 'Lakeside', 'Lakeregion', 'USA', 'House', 'Lakefront estate with dock and boathouse',
        'Lakeview Mansion', 15000, 4),
       ('505 Vine St', 'Winerytown', 'Wineryregion', 'USA', 'Villa',
        'Charming vineyard villa with wine tasting experience', 'Vineyard Villa', 8000, 5);


-- Sample data for PropertyReview table
INSERT INTO PropertyReview (content, travelerID, propertyID)
VALUES ('Great property, excellent location!', 1, 1),
       ('Enjoyed our stay, would recommend to others.', 3, 3),
       ('Property was clean and well-maintained.', 2, 2),
       ('Had a wonderful experience, will definitely return.', 4, 4),
       ('Overall, a pleasant stay at this property.', 5, 5);

-- Sample data for Stay_Messages table
INSERT INTO Stay_Messages (content, travelerID, ownerID)
VALUES ('Hi, we''ve arrived at the property. Everything looks good!', 1, 1),
       ('Could you please provide directions to the property?', 3, 2),
       ('We''re interested in booking your property for next month.', 2, 3),
       ('Is early check-in available for our stay?', 4, 4),
       ('Thank you for hosting us, we had a great time!', 5, 5);


-- Sample data for Stay_At table
INSERT INTO Stay_At (startDate, endDate, travelerID, propertyID)
VALUES ('2023-07-20', '2023-07-25', 1, 1),
       ('2023-08-15', '2023-08-20', 3, 2),
       ('2023-09-05', '2023-09-10', 2, 3),
       ('2023-10-10', '2023-10-15', 4, 4),
       ('2023-11-15', '2023-11-20', 5, 5);


-- Sample data for ExperienceProviders table
INSERT INTO ExperienceProviders (companyName, address, city, region, country, email, description)
VALUES ('Adventure Co.', '123 Adventure Ave', 'Denver', 'CO', 'USA', 'info@adventureco.com',
        'Offering exciting outdoor experiences.'),
       ('Cultural Tours Inc.', '456 Cultural St', 'New York', 'NY', 'USA', 'info@culturaltours.com',
        'Specializing in cultural immersion tours.'),
       ('Extreme Sports Ltd.', '789 Thrill St', 'Los Angeles', 'CA', 'USA', 'info@extremesports.com',
        'Providing adrenaline-pumping activities.'),
       ('Nature Explorers', '101 Nature Trail', 'Seattle', 'WA', 'USA', 'info@natureexplorers.com',
        'Explore the wonders of nature with us.'),
       ('Foodie Adventures', '202 Food St', 'San Francisco', 'CA', 'USA', 'info@foodieadventures.com',
        'Indulge in delicious culinary experiences.');

-- Sample data for AdLiaison table
INSERT INTO AdLiaison (first_name, last_name, email)
VALUES ('Sarah', 'Johnson', 'sarahjohnson@example.com'),
       ('Kevin', 'Brown', 'kevinbrown@example.com'),
       ('Emma', 'Wilson', 'emmawilson@example.com'),
       ('Ryan', 'Taylor', 'ryantaylor@example.com'),
       ('Lisa', 'Martinez', 'lisamartinez@example.com');

-- Sample data for Advertiser table
INSERT INTO Advertiser (first_name, last_name, companyName, email, package, liaisonID)
VALUES ('Mark', 'Jones', 'Adventure Co.', 'markjones@adventureco.com', 'Gold', 1),
       ('Laura', 'Lee', 'Cultural Tours Inc.', 'lauralee@culturaltours.com', 'Silver', 2),
       ('Sam', 'Smith', 'Extreme Sports Ltd.', 'samsmith@extremesports.com', 'Bronze', 3),
       ('Rachel', 'Roberts', 'Nature Explorers', 'rachelroberts@natureexplorers.com', 'Platinum', 4),
       ('Chris', 'Clark', 'Foodie Adventures', 'chrisclark@foodieadventures.com', 'Gold', 5);

-- Sample data for Experience_Ads table
INSERT INTO Experience_Ads (package, providerID, advertiserID)
VALUES ('Gold', 1, 1),
       ('Silver', 2, 2),
       ('Bronze', 3, 3),
       ('Platinum', 4, 4),
       ('Gold', 5, 5);

-- Sample data for Experience_Reviews table
INSERT INTO Experience_Reviews (content, providerID, travelerID)
VALUES ('Had an amazing adventure with Adventure Co.!', 1, 1),
       ('Enjoyed the cultural tour, highly recommended!', 2, 2),
       ('Extreme Sports Ltd. provided an unforgettable experience!', 3, 3),
       ('Nature Explorers tour was fantastic, will definitely do it again.', 4, 4),
       ('Foodie Adventures offered delicious food and great company!', 5, 5);

-- Sample data for Bundle table
INSERT INTO Bundle (description, type, title, price)
VALUES ('Experience nature like never before!', 'Adventure', 'Nature Retreat', 200),
       ('Immerse yourself in the local culture.', 'Cultural', 'City Tour', 100),
       ('Feel the adrenaline rush with extreme sports!', 'Adventure', 'Extreme Adventure', 150),
       ('Explore the culinary delights of the region.', 'Food', 'Foodie Tour', 120),
       ('Discover hidden gems with our off-the-beaten-path tours.', 'Adventure', 'Hidden Treasures', 180);

-- Sample data for Offer table
INSERT INTO Offer (bundleID, providerID)
VALUES (1, 4),
       (2, 3),
       (3, 1),
       (4, 5),
       (5, 2);

-- Sample data for Travel_Data table
INSERT INTO Travel_Data (travelerID, advertiserID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Sample data for Property_Data table
INSERT INTO Property_Data (advertiserID, propertyID)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5);

-- Sample data for Experience table-- Sample data for Experience table
INSERT INTO Experience (date, bundleID, travelerID)
VALUES ('2023-07-25', 1, 1),
       ('2023-08-05', 2, 2),
       ('2023-09-10', 3, 3),
       ('2023-10-05', 4, 4),
       ('2023-11-30', 5, 5);