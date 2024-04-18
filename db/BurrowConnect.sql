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

INSERT INTO Owner (OwnerID, first_name, last_name, email, gender, age, bio)
VALUES
(1,'Merrily','Hindrick','mhindrick0@joomla.org','Female',68,'Welcome to my cozy retreat in the heart of the countryside! Located in a quaint village surrounded by rolling hills, my charming cottage offers a peaceful escape from the hustle and bustle of city life. Perfect for nature lovers and those seeking tranquility.'),

(2,'Ashton','Rainton','arainton1@creativecommons.org','Male',35,'Experience urban living at its finest in my modern loft apartment! Situated in the vibrant downtown area, my stylish space boasts breathtaking views of the city skyline. With trendy cafes, shops, and attractions right at your doorstep, you will never run out of things to do.'),

(3,'Jermaine','Kenshole','jkenshole2@behance.net','Female',52,'Escape to my serene beachfront villa for the ultimate seaside getaway! Nestled along the pristine shores of a secluded island, my luxurious retreat offers panoramic ocean views and direct access to a private stretch of sandy beach. Paradise awaits!'),

(4,'Kyle','Partrick','kpartrick3@spiegel.de','Male',61,'Welcome to my charming countryside farmhouse! Tucked away amidst picturesque farmland, my rustic retreat exudes country charm and character. Enjoy tranquil walks in the surrounding fields or cozy up by the fireplace with a good book.'),

(5,'Fields','Pigeon','fpigeon4@ask.com','Male',28,'Experience the magic of the mountains in my secluded cabin retreat! Surrounded by towering pine trees and majestic peaks, my cozy cabin offers the perfect blend of rustic charm and modern comfort. Ideal for outdoor enthusiasts and adventure seekers.'),

(6,'Huntington','Itzcak','hitzcak5@amazon.co.jp','Male',24,'Welcome to my urban oasis in the heart of the city! Nestled in a bustling neighborhood, my stylish apartment offers the perfect blend of comfort and convenience. With trendy cafes, parks, and attractions nearby, you will love exploring everything the city has to offer.'),

(7,'Rod','Aron','raron6@exblog.jp','Male',57,'Escape to my tranquil countryside retreat for a rejuvenating getaway! Surrounded by lush greenery and rolling hills, my cozy cottage offers the perfect escape from the hustle and bustle of everyday life. Relax on the porch with a cup of tea or explore the scenic countryside at your leisure.'),

(8,'Valli','Dimic','vdimic7@yale.edu','Bigender',42,'Welcome to my eclectic urban loft in the heart of the city! With its vibrant decor and artistic flair, my stylish apartment offers a unique and memorable stay. Located in a trendy neighborhood with plenty of cafes, galleries, and shops nearby, you will experience the best of city living.'),

(9,'Kip','Jedrachowicz','kjedrachowicz8@blinklist.com','Male',44,'Experience the charm of the countryside in my cozy farmhouse retreat! Surrounded by rolling hills and farmland, my rustic cottage offers a peaceful escape from the hustle and bustle of city life. Enjoy scenic walks, cozy nights by the fire, and fresh country air.'),

(10,'Kasper','Banbrook','kbanbrook9@army.mil','Male',48,'Welcome to my beachfront paradise! Nestled along the sandy shores of a secluded bay, my luxurious villa offers stunning ocean views and direct beach access. With spacious living areas, private pool, and outdoor dining area, it is the perfect destination for a relaxing getaway.'),

(11,'Wesley','MacKey','wmackeya@oaic.gov.au','Male',31,'Welcome to my cozy city apartment! Located in the heart of downtown, my modern space offers convenience and comfort. With top-rated restaurants, shops, and attractions just steps away, you will love exploring the vibrant city scene.'),

(12,'Dara','Dallison','ddallisonb@narod.ru','Female',24,'Escape to my peaceful countryside retreat for a relaxing getaway! Nestled amidst scenic farmland, my cozy cottage offers the perfect blend of rustic charm and modern comfort. Enjoy scenic walks, cozy evenings by the fire, and fresh country air.'),

(13,'Lindy','Thickin','lthickinc@mashable.com','Male',70,'Welcome to my lakeside cabin retreat! Situated on the shores of a tranquil lake, my cozy cabin offers breathtaking views and a serene atmosphere. Perfect for fishing, kayaking, or simply relaxing by the water.'),

(14,'Delly','Cumbers','dcumbersd@dailymotion.com','Female',44,'Experience the beauty of the countryside in my charming farmhouse retreat! Surrounded by lush greenery and rolling hills, my cozy cottage offers a peaceful escape from the hustle and bustle of city life. Relax on the porch with a glass of wine or explore the scenic countryside at your leisure.'),

(15,'Dehlia','Belchamber','dbelchambere@ask.com','Female',42,'Welcome to my tranquil seaside escape! Nestled along the pristine shores of a secluded beach, my luxurious villa offers panoramic ocean views and direct access to the sand. With spacious living areas, private pool, and outdoor dining area, it is the perfect destination for a relaxing getaway.'),

(16,'Perla','Beecker','pbeeckerf@goo.ne.jp','Female',44,'Escape to my charming countryside cottage for a peaceful retreat! Surrounded by picturesque farmland, my cozy cottage offers the perfect blend of rustic charm and modern comfort. Enjoy scenic walks, cozy nights by the fire, and breathtaking views of the countryside.'),

(17,'Jodie','Grishunin','jgrishuning@sitemeter.com','Female',62,'Welcome to my cozy mountain cabin! Tucked away amidst towering pine trees and majestic peaks, my rustic cabin offers a peaceful retreat in nature. Enjoy hiking, skiing, or simply relaxing on the porch with a good book and a cup of hot cocoa.'),

(18,'Merrile','Falla','mfallah@bbb.org','Female',46,'Experience the charm of the countryside in my quaint farmhouse retreat! Surrounded by rolling hills and farmland, my cozy cottage offers a peaceful escape from the hustle and bustle of city life. Enjoy scenic walks, fresh country air, and cozy nights by the fire.'),

(19,'Kalindi','Kynvin','kkynvini@people.com.cn','Female',27,'Welcome to my secluded forest retreat! Nestled amidst towering trees and lush greenery, my cozy cabin offers a peaceful escape from the outside world. With hiking trails, wildlife, and breathtaking views right at your doorstep, you will love reconnecting with nature.'),

(20,'Wade','Kuschke','wkuschkej@un.org','Male',42,'Escape to my luxurious beachfront villa for a tropical getaway! Located on a pristine sandy beach, my spacious villa offers stunning ocean views and direct beach access. With modern amenities, private pool, and outdoor lounge area, it is the perfect destination for a relaxing vacation.'),

(21,'Chrissy','Luparto','clupartok@stumbleupon.com','Female',36,'Welcome to my charming countryside cottage! Surrounded by rolling hills and picturesque farmland, my cozy cottage offers a peaceful retreat from the hustle and bustle of city life. Enjoy scenic walks, fresh country air, and cozy nights by the fire.'),

(22,'Filmer','Truter','ftruterl@soup.io','Male',31,'Experience the beauty of nature in my secluded cabin retreat! Tucked away amidst towering trees and lush greenery, my cozy cabin offers a peaceful escape from the outside world. Enjoy hiking, birdwatching, or simply relaxing on the porch surrounded by nature.'),

(23,'Peg','Mattson','pmattsonm@bbc.co.uk','Female',47,'Welcome to my tranquil lakeside retreat! Nestled on the shores of a pristine lake, my cozy cabin offers breathtaking views and a serene atmosphere. With fishing, kayaking, and swimming right at your doorstep, you will love reconnecting with nature.'),

(24,'Carlita','Penman','cpenmann@hubpages.com','Female',67,'Escape to my charming countryside cottage for a relaxing getaway! Surrounded by rolling hills and picturesque farmland, my cozy cottage offers a peaceful retreat in nature. Enjoy scenic walks, fresh country air, and cozy nights by the fire.'),

(25,'Gusti','Murrell','gmurrello@wikia.com','Female',20,'Welcome to my cozy cabin retreat in the woods! Nestled amidst towering trees and lush greenery, my rustic cabin offers a peaceful escape from the hustle and bustle of city life. Enjoy hiking, birdwatching, or simply relaxing on the porch surrounded by nature.'),

(26,'Winifield','Ellingham','wellinghamp@noaa.gov','Male',35,'Experience the beauty of nature in my secluded mountain cabin! Tucked away amidst towering pine trees and majestic peaks, my cozy cabin offers a peaceful retreat in the wilderness. Enjoy hiking, skiing, or simply relaxing by the fireplace with a good book.'),

(27,'Suzi','Larkby','slarkbyq@smh.com.au','Female',62,'Welcome to my charming countryside cottage! Surrounded by rolling hills and picturesque farmland, my cozy cottage offers a peaceful retreat from the hustle and bustle of city life. Enjoy scenic walks, fresh country air, and cozy nights by the fire.'),

(28,'Hank','Sidary','hsidaryr@house.gov','Male',25,'Escape to my tranquil lakeside cabin for a relaxing getaway! Nestled on the shores of a pristine lake, my cozy cabin offers breathtaking views and a serene atmosphere. With fishing, kayaking, and swimming right at your doorstep, you will love reconnecting with nature.'),

(29,'Hazel','Capner','hcapners@weibo.com','Female',63,'Welcome to my charming countryside cottage! Surrounded by rolling hills and picturesque farmland, my cozy cottage offers a peaceful retreat from the hustle and bustle of city life. Enjoy scenic walks, fresh country air, and cozy nights by the fire.'),

(30,'Malachi','Rosellini','mrosellinit@weather.com','Male',44,'Experience the beauty of the countryside in my cozy farmhouse retreat! Surrounded by rolling hills and farmland, my rustic cottage offers a peaceful escape from the hustle and bustle of city life. Enjoy scenic walks, fresh country air, and cozy nights by the fire.');


-- Sample data for Traveler table

INSERT INTO Traveler (TravelerID, first_name, last_name, email, gender, age, bio)
VALUES
(1,'Zebulen','Crebbin','zcrebbin0@discuz.net','Male',69,'Hello fellow travelers! I am Zebulen, an avid adventurer with a passion for exploring new destinations and experiencing different cultures. From hiking in the mountains to diving in the ocean, I am always seeking new adventures to embark on.'),

(2,'Lilli','Kilfeder','lkilfeder1@mysql.com','Female',27,'Greetings! I am Lilli, a wanderlust-filled soul on a quest to discover the beauty of the world. Whether it is strolling through bustling markets or soaking up the sun on pristine beaches, I am always up for an adventure!'),

(3,'Jere','Aston','jaston2@kickstarter.com','Male',30,'Hey there! I am Jere, a travel enthusiast with a love for exploring off-the-beaten-path destinations. From sampling local cuisine to immersing myself in traditional customs, I believe that travel is the best way to broaden the mind and nourish the soul.'),

(4,'Vonnie','Primmer','vprimmer3@archive.org','Female',29,'Hola amigos! I am Vonnie, a free-spirited traveler with a thirst for adventure and a heart full of wanderlust. Whether it is trekking through dense jungles or wandering ancient streets, I am always ready to embrace the unknown and create unforgettable memories.'),

(5,'Alwyn','Neave','aneave4@reuters.com','Genderfluid',29,'Greetings fellow explorers! I am Alwyn, a genderfluid traveler with a passion for discovering hidden gems and uncovering the rich tapestry of cultures that make our world so diverse. Join me on my journey as I seek out new experiences and forge connections with people from all walks of life.'),

(6,'Sheela','Noone','snoone5@ning.com','Bigender',63,'Namaste! I am Sheela, a bigender traveler on a mission to seek enlightenment through exploration and adventure. From meditating in serene temples to hiking through majestic mountains, I am always in search of spiritual fulfillment and inner peace.'),

(7,'Elene','Moggle','emoggle6@freewebs.com','Female',60,'Hello fellow wanderers! I am Elene, a seasoned traveler with a love for immersing myself in the beauty and culture of new destinations. Whether it is admiring breathtaking landscapes or sampling exotic cuisines, I am always ready to embark on a new adventure.'),

(8,'Lelia','Lowdham','llowdham7@weebly.com','Female',70,'Bonjour! I am Lelia, a mature traveler with a zest for life and a passion for exploration. Whether it is sipping wine in charming vineyards or wandering through historic landmarks, I believe that age is just a number when it comes to embracing new experiences.'),

(9,'Cindy','Hallums','challums8@istockphoto.com','Female',39,'Hey there! I am Cindy, a travel-loving soul with a penchant for discovering the beauty and wonder of our world. Whether it is wandering through bustling cities or escaping to tranquil countryside retreats, I am always seeking new adventures to fuel my wanderlust.'),

(10,'Danella','Flexman','dflexman9@webnode.com','Female',51,'Hola amigos! I am Danella, a spirited traveler with a love for embracing the vibrant cultures and traditions of new destinations. Whether it is dancing to the rhythm of salsa in lively plazas or savoring exotic flavors in bustling markets, I am always ready to dive headfirst into new experiences.'),

(11,'Suellen','Tuftin','stuftina@sun.com','Female',32,'Hey there! I am Suellen, a passionate traveler with a thirst for adventure and a heart full of wanderlust. Whether it is trekking through rugged mountains or exploring ancient ruins, I am always seeking new experiences and unforgettable memories.'),

(12,'Uriah','Rembrant','urembrantb@cam.ac.uk','Male',63,'Greetings fellow adventurers! I am Uriah, a seasoned traveler with a love for exploring the world and discovering its hidden treasures. Whether it is marveling at natural wonders or immersing myself in local cultures, I believe that travel is the ultimate form of education and enlightenment.'),

(13,'Fanni','Whinney','fwhinneyc@answers.com','Female',44,'Hello fellow wanderers! I am Fanni, a travel enthusiast with a passion for discovering the beauty and diversity of our world. Whether it is exploring ancient ruins or relaxing on pristine beaches, I am always seeking new adventures to ignite my curiosity.'),

(14,'Alex','Jeanneau','ajeanneaud@homestead.com','Male',44,'Greetings! I am Alex, an intrepid traveler with a love for exploring the great outdoors and experiencing the thrill of adventure. Whether it is hiking through rugged wilderness or camping under the stars, I am always ready to embrace the call of the wild.'),

(15,'Dolorita','Hoyland','dhoylande@squidoo.com','Female',66,'Hola amigos! I am Dolorita, a seasoned traveler with a love for immersing myself in the beauty and culture of new destinations. Whether it is admiring breathtaking landscapes or sampling exotic cuisines, I am always ready to embark on a new adventure.'),

(16,'Jabez','Sparks','jsparksf@elpais.com','Male',31,'Hey there! I am Jabez, a passionate traveler with a thirst for adventure and a love for discovering new experiences. Whether it is exploring ancient ruins or trekking through remote wilderness, I am always seeking new adventures to satisfy my wanderlust.'),

(17,'Godwin','Pentony','gpentonyg@freewebs.com','Male',25,'Hello fellow adventurers! I am Godwin, an intrepid traveler with a passion for exploring the world and experiencing its wonders. Whether it is diving into crystal-clear waters or hiking through rugged mountains, I am always ready to embrace the thrill of adventure.'),

(18,'Mikaela','Kennagh','mkennaghh@yellowpages.com','Female',63,'Greetings fellow wanderers! I am Mikaela, a seasoned traveler with a love for immersing myself in the beauty and culture of new destinations. Whether it is exploring ancient ruins or relaxing on pristine beaches, I am always ready to embark on a new adventure.'),

(19,'Loleta','Feeham','lfeehami@google.co.uk','Female',19,'Hey there! I am Loleta, a young adventurer with a passion for exploring the world and experiencing new cultures. Whether it is backpacking through scenic landscapes or volunteering in local communities, I am always seeking new adventures to broaden my horizons.'),

(20,'Titos','Chittem','tchittemj@google.ca','Male',44,'Greetings fellow travelers! I am Titos, an intrepid explorer with a thirst for adventure and a love for discovering the beauty of our world. Whether it is trekking through rugged wilderness or exploring ancient ruins, I am always ready to embrace the thrill of discovery.'),

(21,'Delmer','Wreakes','dwreakesk@theatlantic.com','Male',40,'Hello fellow adventurers! I am Delmer, an intrepid traveler with a passion for exploring the world and experiencing its wonders. Whether it is diving into crystal-clear waters or hiking through rugged mountains, I am always ready to embrace the thrill of adventure.'),

(22,'Harriett','Hallyburton','hhallyburtonl@joomla.org','Female',28,'Hola amigos! I am Harriett, a spirited traveler with a love for immersing myself in the beauty and culture of new destinations. Whether it is exploring vibrant cities or relaxing on pristine beaches, I am always ready to embark on a new adventure.'),

(23,'Carolee','Davidofski','cdavidofskim@timesonline.co.uk','Polygender',25,'Hey there! I am Carolee, a polygender traveler with a passion for exploring the world and experiencing its diverse cultures. Whether it is wandering through ancient cities or hiking in remote wilderness, I am always seeking new adventures to broaden my horizons.'),

(24,'Hillary','Morffew','hmorffewn@simplemachines.org','Female',47,'Greetings fellow travelers! I am Hillary, a seasoned explorer with a love for immersing myself in the beauty and culture of new destinations. Whether it is sampling local cuisine or admiring breathtaking landscapes, I am always ready to embark on a new adventure.'),

(25,'Livvyy','Riddick','lriddicko@hexun.com','Female',44,'Hello fellow wanderers! I am Livvyy, a travel enthusiast with a passion for discovering the beauty and diversity of our world. Whether it is exploring ancient ruins or relaxing on pristine beaches, I am always seeking new adventures to ignite my curiosity.'),

(26,'Franny','Andric','fandricp@cafepress.com','Female',66,'Hey there! I am Franny, a seasoned traveler with a love for immersing myself in the beauty and culture of new destinations. Whether it is admiring historic landmarks or sampling delicious cuisine, I am always ready to embark on a new adventure.'),

(27,'Findley','Alessandrini','falessandriniq@stanford.edu','Male',68,'Greetings fellow adventurers! I am Findley, an intrepid explorer with a thirst for adventure and a love for discovering the beauty of our world. Whether it is trekking through rugged wilderness or exploring ancient ruins, I am always ready to embrace the thrill of discovery.'),

(28,'Bronny','DAbbot-Doyle','bdabbotdoyler@list-manage.com','Male',56,'Hello fellow travelers! I am Bronny, an intrepid explorer with a passion for discovering the beauty and diversity of our world. Whether it is hiking through lush forests or exploring ancient ruins, I am always seeking new adventures to satisfy my wanderlust.'),

(29,'Wake','Lightwood','wlightwoods@oaic.gov.au','Male',44,'Hey there! I am Wake, a seasoned traveler with a love for immersing myself in the beauty and culture of new destinations. Whether it is hiking through rugged mountains or relaxing on pristine beaches, I am always ready to embark on a new adventure.'),

(30,'Eugene','Linge','elinget@livejournal.com','Polygender',58,'Greetings fellow wanderers! I am Eugene, a polygender traveler with a thirst for adventure and a love for discovering new experiences. Whether it is exploring vibrant cities or trekking through remote wilderness, I am always seeking new adventures to broaden my horizons.');

-- Sample data for Property table

INSERT INTO Property (PropertyID, address, city, region, country, price, type, description, OwnerID)
VALUES
(1, 'PO Box 27473', 'Niort', 'Poitou-Charentes', 'France', '$550.76', 'Apartment', 'Cozy apartment located in the heart of Niort, offering easy access to local attractions and amenities.', 21),

(2, 'PO Box 23431', 'Xinchengzi', NULL, 'China', '$1644.49', 'Luxury Villa', 'Luxurious villa nestled amidst picturesque surroundings in Xinchengzi, perfect for a tranquil getaway.', 20),

(3, 'PO Box 4402', 'Kazlų Rūda', NULL, 'Lithuania', '$1654.26', 'Cottage', 'Charming cottage in the countryside of Kazlų Rūda, offering a peaceful retreat amidst nature.', 28),

(4, 'PO Box 72848', 'Tampa', 'Florida', 'United States', '$2150.58', 'Single-Family Home', 'Spacious single-family home located in the vibrant city of Tampa, ideal for families or groups.', 1),

(5, 'PO Box 49723', 'Vykhino-Zhulebino', NULL, 'Russia', '$2384.81', 'Townhouse', 'Modern townhouse in Vykhino-Zhulebino, featuring contemporary design and convenient access to urban amenities.', 21),

(6, 'Apt 834', 'Estoril', 'Lisboa', 'Portugal', '$1224.39', 'Beach House', 'Quaint beach house in Estoril, offering stunning ocean views and a relaxed coastal atmosphere.', 29),

(7, 'Apt 1309', 'General Enrique Mosconi', NULL, 'Argentina', '$1681.94', 'Ranch', 'Sprawling ranch estate in General Enrique Mosconi, perfect for experiencing the rustic charm of rural Argentina.', 18),

(8, '17th Floor', 'Leluo', NULL, 'China', '$2447.22', 'Penthouse', 'Elegant penthouse on the 17th floor in Leluo, boasting panoramic city views and luxurious amenities.', 24),

(9, 'PO Box 82717', 'Dulangan', NULL, 'Philippines', '$2984.92', 'Beachfront Villa', 'Exquisite beachfront villa in Dulangan, offering direct access to pristine sandy shores and crystal-clear waters.', 26),

(10, 'Room 1231', 'Dem’yanovo', NULL, 'Russia', '$426.96', 'Cabin', 'Quaint cabin nestled in the woods of Dem’yanovo, providing a cozy retreat for nature lovers.', 11),

(11, 'Apt 567', 'Baishi', NULL, 'China', '$1124.75', 'Loft', 'Stylish loft apartment in Baishi, featuring industrial-chic design elements and open-concept living spaces.', 14),

(12, 'PO Box 45990', 'Zhentou', NULL, 'China', '$849.03', 'Bungalow', 'Tranquil bungalow retreat in Zhentou, surrounded by lush greenery and offering serene natural surroundings.', 1),

(13, 'Suite 78', 'Coromandel', NULL, 'New Zealand', '$525.69', 'Chalet', 'Quaint alpine chalet in Coromandel, providing a cozy base for exploring the nearby mountains and forests.', 7),

(14, 'Suite 99', 'Listvyanka', NULL, 'Russia', '$1809.31', 'Lake House', 'Picturesque lake house in Listvyanka, offering breathtaking views of Lake Baikal and the surrounding landscape.', 8),

(15, '4th Floor', 'Riti', NULL, 'Nigeria', '$2484.97', 'Mansion', 'Grand mansion on the 4th floor in Riti, featuring opulent interiors and expansive grounds for luxurious living.', 26),

(16, 'Suite 97', 'Carmen', NULL, 'Philippines', '$1286.57', 'Treehouse', 'Unique treehouse accommodation in Carmen, providing a whimsical and adventurous lodging experience.', 10),

(17, 'Suite 99', 'Xinglong', NULL, 'China', '$2704.82', 'Castle', 'Majestic castle estate in Xinglong, offering a regal retreat with medieval-inspired architecture and lavish amenities.', 2),

(18, '20th Floor', 'Pindaré Mirim', NULL, 'Brazil', '$467.95', 'Duplex', 'Modern duplex apartment on the 20th floor in Pindaré Mirim, featuring sleek design and stunning city views.', 16),

(19, '10th Floor', 'Trollhättan', 'Västra Götaland', 'Sweden', '$635.96', 'Villa', 'Elegant villa on the 10th floor in Trollhättan, blending contemporary luxury with Scandinavian design principles.', 5),

(20, 'Suite 12', 'Mendes', NULL, 'Brazil', '$1830.79', 'Riverside Cabin', 'Charming riverside cabin in Mendes, offering a tranquil escape with scenic views of the surrounding nature and river.', 14),

(21, 'Apt 1102', 'Fatuhilik', NULL, 'Indonesia', '$1284.06', 'Tent', 'Comfortable tent accommodation in Fatuhilik, providing a unique and immersive camping experience amidst nature.', 22),

(22, 'PO Box 65954', 'Xuefeng', NULL, 'China', '$1249.30', 'Farmhouse', 'Quaint farmhouse retreat in Xuefeng, offering a peaceful setting amidst rolling hills and farmland.', 16),

(23, 'PO Box 30867', 'Štítina', NULL, 'Czech Republic', '$2005.15', 'Manor House', 'Historic manor house in Štítina, exuding old-world charm and elegance with its stately architecture and lush gardens.', 26),

(24, 'PO Box 45364', 'Cabinda', NULL, 'Angola', '$2202.82', 'Beachfront Bungalow', 'Idyllic beachfront bungalow in Cabinda, offering a secluded retreat with panoramic ocean views and pristine sandy shores.', 30),

(25, 'Apt 1130', 'Lago', NULL, 'Sierra Leone', '$494.24', 'Houseboat', 'Quirky houseboat accommodation in Lago, providing a unique lodging experience on the tranquil waters of Sierra Leone.', 1),

(26, 'Suite 62', 'Toledo', 'Ohio', 'United States', '$1799.07', 'Historic Mansion', 'Stately historic mansion in Toledo, Ohio, offering elegant accommodations and a glimpse into the city''s rich heritage.', 27),

(27, 'PO Box 2875', 'Marcos', NULL, 'Philippines', '$2510.45', 'Resort Villa', 'Luxurious resort villa in Marcos, featuring upscale amenities and exclusive access to private beaches and leisure facilities.', 6),

(28, '5th Floor', 'Kamyanyets', NULL, 'Belarus', '$1873.61', 'Chateau', 'Enchanting chateau estate on the 5th floor in Kamyanyets, offering a romantic escape amidst lush gardens and scenic vistas.', 12),

(29, '2nd Floor', 'Terenozek', NULL, 'Kazakhstan', '$2715.81', 'Ski Chalet', 'Cosy ski chalet accommodation in Terenozek, perfect for winter sports enthusiasts seeking comfort and convenience near the slopes.', 18),

(30, '15th Floor', 'Wenchang', NULL, 'China', '$613.10', 'Studio Apartment', 'Compact studio apartment on the 15th floor in Wenchang, providing modern amenities and convenient urban living in the heart of the city.', 13);



-- Sample data for PropertyReviews table

INSERT INTO PropertyReview (ReviewID, ReviewDate, content, TravelerID, PropertyID)
VALUES
(1, '11/16/2014', 'I had a wonderful stay at this farmhouse in Xuefeng. The rustic charm of the property combined with the serene surroundings made for a truly relaxing getaway.', 7, 22),
(2, '8/21/2011', 'The penthouse in Leluo exceeded all my expectations! The breathtaking views from the 17th floor and the luxurious amenities made for an unforgettable experience.', 14, 8),
(3, '5/8/2023', 'Unfortunately, my experience at this bungalow in Zhentou was disappointing. The accommodation felt outdated and lacked basic amenities. Not recommended.', 19, 12),
(4, '3/27/2023', 'Staying on a houseboat in Lago was a unique and memorable experience. The cozy interiors and gentle rocking of the boat made for a peaceful retreat.', 25, 25),
(5, '6/21/2011', 'The beachfront bungalow in Cabinda was everything I hoped for and more! The stunning ocean views and secluded location made it the perfect spot for relaxation.', 11, 24),
(6, '1/14/2017', 'I thoroughly enjoyed my stay at the mansion in Riti. The grandeur of the property and the impeccable service exceeded my expectations.', 12, 15),
(7, '7/12/2000', 'The treehouse in Carmen was a unique and adventurous lodging choice. Falling asleep to the sounds of nature was truly magical.', 10, 16),
(8, '8/2/2017', 'The villa in Trollhättan was simply stunning! The modern amenities and stylish decor made for a comfortable and luxurious stay.', 15, 5),
(9, '6/11/2015', 'My experience at the castle in Xinglong was nothing short of enchanting. The historic ambiance and opulent interiors made me feel like royalty.', 18, 17),
(10, '9/23/2014', 'I had a fantastic time at this manor house in Štítina. The elegant surroundings and picturesque gardens made for a truly memorable stay.', 26, 23),
(11, '6/1/2011', 'The historic mansion in Toledo was a delight to stay in. The rich history of the property and its elegant furnishings made it a truly unique experience.', 27, 27),
(12, '5/21/2007', 'Unfortunately, my experience at this houseboat in Lago fell short of expectations. The accommodations were cramped and the facilities were lacking.', 21, 25),
(13, '12/17/2001', 'Staying at this manor house in Štítina was like stepping back in time. The historic charm of the property and its beautiful gardens made for a memorable stay.', 15, 23),
(14, '9/14/2009', 'The alpine chalet in Coromandel was the perfect base for exploring the surrounding mountains. The cozy interiors and stunning views made it a wonderful retreat.', 2, 18),
(15, '5/10/2010', 'I thoroughly enjoyed my stay at this farmhouse in Xuefeng. The rustic charm of the property and the tranquil surroundings made for a relaxing getaway.', 8, 22),
(16, '3/27/2007', 'My experience at this duplex in Pindaré Mirim was fantastic. The modern amenities and convenient location made for a comfortable and enjoyable stay.', 28, 18),
(17, '2/6/2008', 'Unfortunately, my experience at this resort villa in Marcos was disappointing. The facilities were run-down and the service was lackluster. Not recommended.', 24, 27),
(18, '11/30/2014', 'The villa in Trollhättan exceeded all my expectations! The luxurious accommodations and stunning views made for an unforgettable stay.', 30, 5),
(19, '12/10/2012', 'I had a wonderful time at this farmhouse in Xuefeng. The serene surroundings and charming interiors made for a truly relaxing retreat.', 7, 22),
(20, '6/26/2016', 'Staying at this beachfront villa in Dulangan was a dream come true! The pristine sandy beach and crystal-clear waters made for an idyllic getaway.', 19, 9),
(21, '12/21/2010', 'The alpine chalet in Coromandel was the perfect spot for a mountain getaway. The cozy interiors and breathtaking views made for a memorable stay.', 20, 13),
(22, '5/22/2011', 'I thoroughly enjoyed my stay at this historic mansion in Toledo. The elegant surroundings and impeccable service made for a truly luxurious experience.', 23, 26),
(23, '11/17/2005', 'Staying at this chateau in Kamyanyets was a fairy-tale experience! The enchanting gardens and elegant interiors made me feel like royalty.', 18, 28),
(24, '12/17/2009', 'Unfortunately, my experience at this beachfront bungalow in Cabinda was disappointing. The accommodations were basic and the beach was overcrowded.', 29, 24),
(25, '1/22/2021', 'The studio apartment in Wenchang was perfect for my solo trip. The modern amenities and convenient location made for a comfortable stay.', 12, 30),
(26, '8/15/2022', 'I had a fantastic time at this manor house in Štítina. The historic charm of the property and its beautiful gardens made for a truly memorable stay.', 11, 26),
(27, '4/19/2001', 'Staying at this resort villa in Niort was a wonderful experience. The luxurious accommodations and attentive service made for a truly relaxing retreat.', 17, 1),
(28, '12/30/2004', 'The bungalow in Zhentou was the perfect spot for a peaceful retreat. The tranquil surroundings and cozy interiors made for a relaxing getaway.', 19, 12),
(29, '6/6/2018', 'Unfortunately, my experience at this ski chalet in Terenozek was disappointing. The accommodations were outdated and the ski slopes were overcrowded.', 23, 29),
(30, '11/11/2000', 'The houseboat in Lago was a unique and memorable lodging choice. The cozy interiors and stunning lake views made for a relaxing retreat.', 8, 25),
(31, '3/13/2015', 'Staying at this beachfront villa in Baishi was a dream come true! The pristine sandy beach and crystal-clear waters made for an idyllic getaway.', 15, 11),
(32, '4/25/2011', 'I thoroughly enjoyed my stay at this beachfront villa in Listvyanka. The breathtaking views and serene surroundings made for a truly relaxing retreat.', 8, 14),
(33, '7/27/2023', 'The cabin in Kazlų Rūda was the perfect spot for a secluded getaway. The cozy interiors and tranquil surroundings made for a relaxing retreat.', 17, 3),
(34, '3/12/2008', 'Unfortunately, my experience at this studio apartment in Wenchang was disappointing. The accommodations were cramped and the location was noisy.', 16, 26),
(35, '1/29/2004', 'Staying at this farmhouse in Xinchengzi was a unique and memorable experience. The rustic charm of the property and the serene surroundings made for a relaxing getaway.', 6, 2),
(36, '9/28/2020', 'The beachfront villa in Fatuhilik was everything I hoped for and more! The stunning ocean views and luxurious amenities made for an unforgettable stay.', 30, 21),
(37, '7/17/2019', 'Unfortunately, my experience at this alpine chalet in Trollhättan was disappointing. The accommodations were basic and the facilities were lacking.', 24, 19),
(38, '11/27/2004', 'I had a fantastic time at this villa in Dulangan. The spacious accommodations and stunning ocean views made for a truly memorable stay.', 2, 15),
(39, '7/28/2021', 'Staying at this treehouse in Estoril was a unique and memorable experience. The cozy interiors and lush surroundings made for a truly relaxing retreat.', 24, 7),
(40, '12/29/2020', 'Unfortunately, my experience at this studio apartment in Wenchang was disappointing. The accommodations were cramped and the facilities were lacking.', 9, 30),
(41, '8/27/2015', 'I thoroughly enjoyed my stay at this resort villa in Marcos. The luxurious accommodations and stunning views made for a truly relaxing retreat.', 12, 27),
(42, '4/5/2006', 'Staying at this ski chalet in Terenozek was a fantastic experience. The cozy interiors and convenient location near the slopes made for a memorable stay.', 13, 29),
(43, '1/30/2006', 'The treehouse in General Enrique Mosconi was the perfect spot for a unique and adventurous getaway. The rustic charm and scenic surroundings made for a memorable stay.', 13, 6),
(44, '2/4/2016', 'Unfortunately, my experience at this beachfront villa in Fatuhilik was disappointing. The accommodations were outdated and the beach was overcrowded.', 11, 21),
(45, '6/21/2023', 'The beachfront villa in Dem’yanovo was everything I hoped for and more! The stunning ocean views and luxurious amenities made for an unforgettable stay.', 11, 10),
(46, '3/13/2013', 'Staying at this ski chalet in Terenozek was a fantastic experience. The cozy interiors and convenient location near the slopes made for a memorable stay.', 23, 29),
(47, '12/5/2009', 'The cabin in Kazlų Rūda was the perfect spot for a secluded getaway. The cozy interiors and tranquil surroundings made for a relaxing retreat.', 18, 3),
(48, '1/5/2003', 'Unfortunately, my experience at this beachfront villa in Fatuhilik was disappointing. The accommodations were outdated and the beach was overcrowded.', 12, 21),
(49, '12/4/2022', 'The beachfront villa in Baishi was everything I hoped for and more! The stunning ocean views and luxurious amenities made for an unforgettable stay.', 8, 11),
(50, '8/4/2020', 'Staying at this ski chalet in Terenozek was a fantastic experience. The cozy interiors and convenient location near the slopes made for a memorable stay.', 23, 29);

-- Sample data for Stay_Messages table


insert into Stay_Messages (MessID, DateSent, content, TravelerID, OwnerID)
values
(2, '8/26/2016', 'Hi! Just checking in to let you know everything is going smoothly. Thanks for the great accommodation!', 21, 18),
(3, '5/21/2011', 'Hey! I hope you are doing well. Just wanted to say thanks for the hospitality!', 30, 23),
(4, '9/9/2015', 'Hello! I am really enjoying my time here. The place is lovely!', 17, 11),
(5, '10/13/2011', 'Hi! Everything is great here. Thanks for making my stay comfortable!', 26, 2),
(6, '8/13/2018', 'Hey there! Just wanted to say thanks for everything. I am having a great time!', 24, 17),
(7, '11/8/2013', 'Hi! Just wanted to let you know I am having a wonderful time. Thanks for everything!', 18, 12),
(8, '11/5/2006', 'Hello! Just checking in to say everything is fantastic. Thanks for being a great host!', 22, 7),
(9, '12/21/2005', 'Hey! I just wanted to express my gratitude for the great stay. Everything is perfect!', 30, 21),
(10, '5/2/2010', 'Hi! I am having a great time here. Thanks for the wonderful accommodation!', 10, 24),
(11, '7/17/2010', 'Hello! Everything is going smoothly here. Thanks for the fantastic place!', 14, 28),
(12, '10/6/2004', 'Hey! Just wanted to say thanks for everything. I am really enjoying my stay!', 19, 9),
(13, '3/8/2000', 'Hi! I hope you are doing well. Just wanted to say thanks for the great accommodation!', 9, 18),
(14, '1/12/2022', 'Hello! Everything is fantastic here. Thanks for the wonderful stay!', 10, 27),
(15, '3/10/2004', 'Hey! Just wanted to let you know I am having a great time. Thanks for everything!', 4, 25),
(16, '12/23/2016', 'Hi! Everything is going smoothly here. Thanks for being a great host!', 26, 28),
(17, '1/21/2020', 'Hello! I am having a fantastic time here. Thanks for everything!', 10, 24),
(18, '8/12/2013', 'Hey! Everything is great here. Thanks for the wonderful accommodation!', 26, 30),
(19, '9/18/2007', 'Hello! Just wanted to say thanks for everything. I am really enjoying my stay!', 23, 1),
(20, '6/11/2006', 'Hi! Everything is fantastic here. Thanks for being a great host!', 27, 7),
(21, '4/4/2007', 'Hey there! Everything is going smoothly here. Thanks for the wonderful stay!', 21, 24),
(22, '9/26/2000', 'Hello! I am having a great time here. Thanks for everything!', 28, 27),
(23, '8/20/2022', 'Hi! Just wanted to say thanks for everything. I am really enjoying my stay!', 10, 26),
(24, '2/5/2019', 'Hey! Everything is fantastic here. Thanks for the wonderful accommodation!', 9, 13),
(25, '2/20/2016', 'Hi! Everything is great here. Thanks for being a great host!', 27, 13),
(26, '1/11/2001', 'Hello! Everything is fantastic here. Thanks for the wonderful stay!', 13, 30),
(27, '12/5/2005', 'Hi! Just wanted to let you know I am having a great time. Thanks for everything!', 6, 5),
(28, '1/12/2001', 'Hey! Everything is going smoothly here. Thanks for being a great host!', 18, 17),
(29, '1/18/2017', 'Hello! Just wanted to say thanks for everything. I am really enjoying my stay!', 19, 5),
(30, '6/30/2023', 'Hi! Everything is fantastic here. Thanks for the wonderful accommodation!', 23, 10),
(31, '3/19/2011', 'Hey! Everything is great here. Thanks for being a great host!', 12, 6),
(32, '10/12/2013', 'Hello! Everything is fantastic here. Thanks for the wonderful stay!', 12, 8),
(33, '9/4/2001', 'Hey! Everything is going smoothly here. Thanks for everything!', 28, 10),
(34, '1/2/2020', 'Hi! Just wanted to say thanks for everything. I am really enjoying my stay!', 13, 17),
(35, '5/17/2009', 'Hey there! Everything is fantastic here. Thanks for the wonderful stay!', 17, 5),
(36, '11/21/2011', 'Hi! Everything is great here. Thanks for being a great host!', 29, 26),
(37, '3/21/2023', 'Hello! I am having a fantastic time here. Thanks for everything!', 4, 7),
(38, '10/27/2006', 'Hi! Just wanted to let you know I am having a great time. Thanks for everything!', 16, 24),
(39, '5/29/2019', 'Hey! Everything is fantastic here. Thanks for the wonderful stay!', 15, 25),
(40, '11/16/2006', 'Hello! Everything is going smoothly here. Thanks for being a great host!', 22, 25),
(41, '7/26/2008', 'Hi! Everything is great here. Thanks for everything!', 2, 15),
(42, '4/15/2003', 'Hey! Just wanted to say thanks for everything. I am really enjoying my stay!', 29, 8),
(43, '10/28/2005', 'Hello! Everything is fantastic here. Thanks for the wonderful stay!', 30, 28),
(44, '5/3/2022', 'Hi! Just wanted to let you know I am having a great time. Thanks for everything!', 24, 3),
(45, '4/2/2019', 'Hey! Everything is fantastic here. Thanks for the wonderful stay!', 22, 22),
(46, '4/2/2020', 'Hello! Everything is going smoothly here. Thanks for being a great host!', 5, 16),
(47, '2/13/2020', 'Hi! Everything is great here. Thanks for the wonderful stay!', 19, 1),
(48, '5/23/2008', 'Hey there! Everything is fantastic here. Thanks for the wonderful stay!', 29, 7),
(49, '3/26/2021', 'Hi! Everything is going smoothly here. Thanks for everything!', 30, 16),
(50, '12/31/2013', 'Hello! Everything is fantastic here. Thanks for being a great host!', 28, 16);

-- Sample data for Stay_At table

insert into Stay_At (StayID, StartDate, EndDate, TravelerID, PropertyID)
values
(1, '8/23/2018', '9/11/2011', 1, 5),
(2, '9/26/2014', '1/1/2013', 17, 13),
(3, '6/7/2009', '9/14/2010', 18, 22),
(4, '5/3/2023', '9/21/2016', 9, 24),
(5, '2/19/2005', '6/23/2009', 24, 19),
(6, '11/18/2018', '10/31/2008', 1, 27),
(7, '8/8/2000', '7/1/2018', 17, 21),
(8, '1/20/2004', '9/17/2017', 5, 4),
(9, '1/9/2019', '9/28/2000', 17, 9),
(10, '8/20/2018', '12/30/2012', 4, 2),
(11, '2/2/2014', '9/6/2015', 6, 8),
(12, '10/17/2017', '6/4/2022', 26, 2),
(13, '5/14/2015', '11/9/2010', 29, 29),
(14, '9/22/2021', '7/29/2011', 3, 23),
(15, '7/18/2005', '12/6/2019', 8, 19),
(16, '4/26/2001', '2/20/2016', 19, 29),
(17, '7/28/2001', '8/5/2002', 12, 17),
(18, '3/31/2009', '6/10/2007', 15, 6),
(19, '10/12/2005', '12/28/2021', 28, 6),
(20, '6/18/2001', '6/9/2007', 10, 26),
(21, '7/10/2014', '11/18/2011', 22, 12),
(22, '4/8/2015', '6/25/2015', 29, 11),
(23, '9/17/2021', '6/5/2000', 12, 14),
(24, '12/8/2003', '11/16/2007', 26, 10),
(25, '9/28/2020', '10/20/2007', 18, 23),
(26, '10/24/2017', '8/29/2018', 20, 7),
(27, '9/29/2023', '8/19/2009', 5, 27),
(28, '8/9/2018', '5/20/2017', 4, 14),
(29, '6/7/2018', '2/23/2008', 6, 4),
(30, '8/27/2006', '8/23/2017', 6, 4),
(31, '8/12/2007', '5/18/2021', 18, 14),
(32, '4/9/2017', '4/17/2006', 1, 29),
(33, '3/1/2009', '5/16/2017', 9, 18),
(34, '2/5/2011', '2/9/2000', 10, 7),
(35, '7/3/2000', '9/4/2004', 25, 16),
(36, '3/22/2014', '10/5/2021', 6, 12),
(37, '8/28/2011', '7/10/2020', 15, 26),
(38, '12/6/2004', '7/15/2015', 23, 10),
(39, '10/29/2009', '6/28/2010', 1, 19),
(40, '2/22/2016', '11/3/2010', 26, 1),
(41, '12/20/2021', '5/6/2017', 13, 11),
(42, '10/29/2018', '2/3/2016', 28, 8),
(43, '4/19/2008', '5/21/2001', 5, 24),
(44, '9/22/2021', '4/15/2017', 2, 6),
(45, '7/5/2016', '12/10/2007', 29, 10),
(46, '7/9/2009', '3/17/2021', 28, 22),
(47, '12/21/2015', '1/12/2024', 12, 21),
(48, '5/27/2005', '6/1/2007', 21, 30),
(49, '10/20/2021', '5/3/2023', 12, 23),
(50, '9/23/2010', '6/3/2005', 8, 21);

-- Sample data for Experience Providers table

INSERT INTO ExperienceProviders (ProviderID, CompanyName, address, city, region, country, email, description) VALUES
(21, 'Swaniawski, Gulgowski and Schuppe', 'Boehm and Sons', 'Bern', 'Kanton Bern', 'Switzerland', 'vvinask@cbc.ca', 'Discover the Swiss Alps with guided hiking tours, cheese-making workshops, and visits to charming alpine villages in Bern, Kanton Bern.'),
(22, 'Schmidt Group', 'Cummings, Ankunding and Cole', 'Yola', NULL, 'Nigeria', 'dtrivettl@howstuffworks.com', 'Explore Nigeria''s cultural heritage with visits to traditional Yoruba villages, drumming and dance performances, and encounters with local artisans in Yola.'),
(23, 'Schmitt, Gulgowski and Ward', 'Stoltenberg, Gibson and Vandervort', 'Clearwater', 'Florida', 'United States', 'gbusherm@wisc.edu', 'Experience the natural beauty of Florida''s Gulf Coast with eco-tours of Clearwater''s mangrove forests, kayaking adventures, and encounters with dolphins and manatees.'),
(24, 'Harber-Wolff', 'Predovic Inc', 'Salgado', NULL, 'Brazil', 'aweighelln@jimdo.com', 'Discover the wonders of the Brazilian Amazon with guided jungle treks, piranha fishing expeditions, and visits to indigenous tribes in Salgado.'),
(25, 'Rowe-Leuschke', 'Koch-Ryan', 'Musanze', NULL, 'Rwanda', 'eeaggero@php.net', 'Embark on a gorilla trekking adventure in Rwanda''s Volcanoes National Park, birdwatching tours, and visits to traditional Rwandan villages in Musanze.'),
(26, 'Towne, Lind and Becker', 'Kovacek-Shanahan', 'Östersund', 'Jämtland', 'Sweden', 'ajullianp@taobao.com', 'Experience the beauty of Sweden''s Jämtland region with guided hikes in Östersund''s pristine wilderness, fishing excursions on tranquil lakes, and visits to traditional Sami reindeer herding communities.'),
(27, 'Medhurst, Kris and Shields', 'Schroeder LLC', 'Wujian', NULL, 'China', 'rmedhurstq@irs.gov', 'Explore the rich history of China''s Wujian province with visits to ancient Buddhist temples, martial arts demonstrations, and traditional tea ceremonies.'),
(28, 'Wiza Inc', 'Von Group', 'Östersund', 'Jämtland', 'Sweden', 'abruyntjesr@discovery.com', 'Discover the beauty of Sweden''s Östersund with guided tours of the city''s historic landmarks, visits to local craft breweries, and culinary experiences featuring traditional Swedish cuisine.'),
(29, 'Romaguera-Fay', 'Feil, Bogan and Walter', 'Bulongji', NULL, 'China', 'aelldreds@google.fr', 'Immerse yourself in the ancient culture of China''s Bulongji with guided tours of Ming Dynasty temples, traditional Chinese painting classes, and performances of Peking Opera.'),
(30, 'Mayert-Jerde', 'Stark, Jakubowski and Gottlieb', 'Charyshskoye', NULL, 'Russia', 'wmeindlt@omniture.com', 'Experience the rugged beauty of Russia''s Altai Mountains with guided treks to remote alpine lakes, horseback riding adventures, and encounters with nomadic Kazakh eagle hunters in Charyshskoye.'),
(31, 'Wehner, Littel and Heidenreich', 'Crooks-Russel', 'Maquanzhen', NULL, 'China', 'cizonu@ox.ac.uk', 'Explore the historic treasures of China''s Maquanzhen with visits to ancient Confucian temples, traditional Chinese medicine clinics, and performances of traditional Chinese music.'),
(32, 'Parker Inc', 'Gorczany-Dooley', 'Kislyakovskaya', NULL, 'Russia', 'kmarksonv@amazon.com', 'Discover the wild beauty of Russia''s Caucasus Mountains with guided hikes through alpine meadows, wildlife tracking tours, and encounters with local shepherd communities in Kislyakovskaya.'),
(33, 'Skiles, Nader and Kiehn', 'Goldner-Miller', 'La Paz', NULL, 'Philippines', 'qmciloryw@bluehost.com', 'Experience the tropical paradise of the Philippines with island-hopping tours, snorkeling adventures in pristine coral reefs, and beachside barbecues in La Paz.'),
(34, 'Kuhn-Kiehn', 'Raynor-Schaden', 'Gagarawa', NULL, 'Nigeria', 'agyvesx@nyu.edu', 'Discover the cultural heritage of Nigeria with visits to traditional Hausa villages, drumming and dance performances, and encounters with local artisans in Gagarawa.'),
(35, 'Huels-O''Conner', 'Moen LLC', 'Nakovo', NULL, 'Serbia', 'gstourtony@cbsnews.com', 'Experience the rustic charm of Serbia with guided tours of Nakovo''s traditional Serbian Orthodox monasteries, wine tastings at local vineyards, and visits to bustling farmer''s markets.'),
(36, 'Romaguera and Sons', 'Upton-Bogisich', 'Lincheng', NULL, 'China', 'lbackshawz@drupal.org', 'Explore the ancient wonders of China''s Lincheng with guided tours of UNESCO World Heritage sites, traditional Chinese painting workshops, and encounters with local craftsmen.'),
(37, 'Beatty and Sons', 'Tremblay Group', 'Oštarije', NULL, 'Croatia', 'sglazer10@people.com.cn', 'Discover the natural beauty of Croatia with guided hikes in Plitvice Lakes National Park, boat tours of coastal villages, and seafood tastings in Oštarije.'),
(38, 'Sporer-Stiedemann', 'Paucek-Auer', 'Awilega', NULL, 'Indonesia', 'sdescoffier11@weibo.com', 'Embark on a cultural adventure in Indonesia with visits to traditional Javanese villages, batik-making workshops, and performances of traditional dance and music in Awilega.'),
(39, 'Steuber-Feeney', 'Considine, Fritsch and Schneider', 'Mozelos', 'Aveiro', 'Portugal', 'tkeal12@tinyurl.com', 'Experience the charm of Portugal''s Aveiro region with guided tours of historic canals, boat rides through picturesque waterways, and tastings of local delicacies in Mozelos.'),
(40, 'Cronin and Sons', 'Wehner-Rau', 'Marseille', 'Provence-Alpes-Côte d''Azur', 'France', 'lgreenacre13@gizmodo.com', 'Discover the vibrant cultural melting pot of Marseille, France, with guided tours of historic neighborhoods, visits to local markets, and culinary experiences featuring traditional Provençal cuisine.'),
(41, 'Torp, Kub and Quitzon', 'Toy LLC', 'Enskede', 'Stockholm', 'Sweden', 'lsearchfield14@slashdot.org', 'Experience the Scandinavian charm of Sweden''s Enskede with guided tours of historic architecture, visits to local museums, and outdoor adventures in nearby forests and lakes.'),
(42, 'Christiansen-Hamill', 'Keeling, Luettgen and McLaughlin', 'Badar', NULL, 'Russia', 'klindwasser15@census.gov', 'Discover the wilderness of Russia''s Far East with guided tours of Badar''s taiga forests, bear-watching expeditions, and encounters with indigenous Evenki reindeer herders.'),
(43, 'Hilll LLC', 'Von and Sons', 'Tongyu', NULL, 'China', 'rplatts16@usa.gov', 'Explore the natural wonders of China''s Tongyu with hikes through karst limestone landscapes, visits to ancient cave complexes, and encounters with local Miao ethnic minority communities.'),
(44, 'Christiansen, Bernhard and Leffler', 'Walker-Mitchell', 'Saint-Leu-la-Forêt', 'Île-de-France', 'France', 'ikerr17@oaic.gov.au', 'Experience the charm of the French countryside with guided tours of Saint-Leu-la-Forêt''s historic chateaus, wine tastings in scenic vineyards, and leisurely picnics in picturesque gardens.'),
(45, 'Kessler-Mueller', 'Howe Group', 'Martaban', NULL, 'Myanmar', 'rklimushev18@hatena.ne.jp', 'Embark on an adventure in Myanmar with riverboat cruises along the Irrawaddy River, visits to ancient Buddhist temples in Bagan, and encounters with local artisans in Martaban.'),
(46, 'Walker-Mosciski', 'Nitzsche, Langworth and Willms', 'Zhonghouhe', NULL, 'China', 'lchelsom19@1688.com', 'Discover the ancient treasures of China''s Zhonghouhe with guided tours of Ming Dynasty fortresses, traditional Chinese medicine clinics, and encounters with local Daoist monks.'),
(47, 'Frami, Hackett and Roberts', 'Beatty-Cassin', 'Longmen', NULL, 'China', 'apettis1a@macromedia.com', 'Experience the grandeur of China''s Longmen with visits to UNESCO World Heritage sites, traditional Chinese calligraphy workshops, and performances of Chinese opera in historic temples.'),
(48, 'Schimmel Inc', 'Dooley, Raynor and Ernser', 'Lefkímmi', NULL, 'Greece', 'dfeldfisher1b@geocities.jp', 'Explore the beauty of Greece''s Corfu island with guided tours of Lefkímmi''s Venetian fortresses, olive oil tastings at local groves, and swimming in pristine beaches.'),
(49, 'Kohler-Ziemann', 'Beer, Ruecker and Lehner', 'Stockholm', 'Stockholm', 'Sweden', 'bchander1c@ft.com', 'Experience the vibrant culture of Stockholm with guided tours of historic Gamla Stan, visits to world-class museums, and cruises through Stockholm''s archipelago.'),
(50, 'Little, Herzog and Connelly', 'Raynor-Smith', 'Alzamay', NULL, 'Russia', 'gsuggate1d@hexun.com', 'Discover the wilderness of Russia''s Siberia with guided tours of Alzamay''s taiga forests, Siberian husky sled rides, and encounters with indigenous Buryat nomads.');

-- Sample data for Experience Review table

INSERT INTO Experience_Reviews (ReviewID, date, content, ProviderID, TravelerID) VALUES
(1, 'Gerrie', 'The eco-tour of Clearwater was absolutely amazing! The mangrove forests were stunning, and we saw so much wildlife. Highly recommend it!', 23, 1),
(2, 'Florie', 'The guided trekking adventure in Russia''s Altai Mountains was an unforgettable experience. The scenery was breathtaking, and our guide was very knowledgeable.', 30, 2),
(3, 'Dewitt', 'The cultural immersion in China''s Lincheng was eye-opening. The UNESCO sites were impressive, and interacting with local craftsmen was a highlight.', 3, 5),
(4, 'Addie', 'Exploring Russia''s Caucasus Mountains was an adventure of a lifetime! The hikes through alpine meadows were beautiful, and we even spotted some wildlife.', 32, 11),
(5, 'Jodi', 'The island-hopping tour in the Philippines was fantastic! Each island had its own unique charm, and the snorkeling was incredible.', 18, 12),
(6, 'Ivy', 'The charm of France''s Saint-Leu-la-Forêt was irresistible. The historic chateaus were stunning, and the wine tastings were delightful.', 44, 6),
(7, 'Pattie', 'Exploring Croatia''s Plitvice Lakes National Park was like stepping into a fairy tale. The guided hikes were informative, and the boat tour was serene.', 16, 13),
(8, 'Georgetta', 'The guided tour of Portugal''s Aveiro region was wonderful. The historic canals were picturesque, and the local delicacies were delicious.', 38, 25),
(9, 'Mayor', 'Indonesia''s Awilega was a cultural delight. The batik-making workshop was fascinating, and the traditional dance performance was captivating.', 39, 20),
(10, 'Fiann', 'The beauty of Greece''s Corfu island was breathtaking. The guided tour of the Venetian fortresses was informative, and the olive oil tastings were a treat.', 48, 21),
(11, 'Cathrine', 'The tour of Switzerland''s Bern was fantastic. The guided hiking tours were exhilarating, and the cheese-making workshop was a unique experience.', 48, 1),
(12, 'Victoir', 'Exploring Nigeria''s Yola was an adventure. The traditional Yoruba villages were fascinating, and the drumming and dance performances were energetic.', 1, 5),
(13, 'Dyna', 'The cultural immersion in China''s Longmen was awe-inspiring. The UNESCO sites were breathtaking, and the Chinese calligraphy workshop was enlightening.', 14, 11),
(14, 'Margery', 'The gorilla trekking adventure in Rwanda was a once-in-a-lifetime experience. Seeing these majestic animals up close was unforgettable.', 11, 27),
(15, 'Paxon', 'The rustic charm of Serbia''s Nakovo was delightful. The Serbian Orthodox monasteries were serene, and the wine tastings were enjoyable.', 35, 9),
(16, 'Antonie', 'Exploring China''s Wujian province was fascinating. The ancient Buddhist temples were impressive, and the traditional tea ceremony was a highlight.', 12, 21),
(17, 'Welby', 'The island-hopping tour in the Philippines was amazing. Each island had its own unique beauty, and the snorkeling was fantastic.', 18, 7),
(18, 'Vonni', 'The guided trekking adventure in Russia''s Altai Mountains was breathtaking. The scenery was stunning, and our guide was very knowledgeable.', 5, 5),
(19, 'Tera', 'The tour of Sweden''s Östersund was wonderful. The guided hikes were informative, and the visits to local craft breweries were enjoyable.', 29, 9),
(20, 'Debera', 'Exploring Nigeria''s Gagarawa was a cultural experience. The traditional Hausa villages were fascinating, and the drumming and dance performances were energetic.', 7, 24),
(21, 'Josefa', 'The cultural immersion in China''s Maquanzhen was enlightening. The ancient Confucian temples were impressive, and the traditional Chinese music performance was beautiful.', 8, 29),
(22, 'Dannel', 'The guided trekking adventure in Russia''s Altai Mountains was unforgettable. The scenery was breathtaking, and our guide was very knowledgeable.', 24, 12),
(23, 'Martha', 'The tour of Sweden''s Östersund was fantastic. The guided hikes were exhilarating, and the fishing excursions were enjoyable.', 29, 18),
(24, 'Milli', 'The guided tour of Switzerland''s Bern was amazing. The hiking tours were breathtaking, and the visits to alpine villages were charming.', 21, 23),
(25, 'Helyn', 'Exploring Brazil''s Salgado was a thrilling adventure. The guided jungle treks were exhilarating, and the encounters with indigenous tribes were eye-opening.', 24, 8),
(26, 'Heloise', 'The cultural immersion in China''s Longmen was fascinating. The UNESCO sites were impressive, and the traditional Chinese painting class was enjoyable.', 14, 6),
(27, 'Quintana', 'The tour of Portugal''s Aveiro region was fantastic. The boat rides were scenic, and the tastings of local delicacies were delicious.', 39, 2),
(28, 'Ricki', 'The cultural immersion in China''s Maquanzhen was enlightening. The ancient Confucian temples were impressive, and the traditional Chinese music performance was beautiful.', 8, 15),
(29, 'Edyth', 'The guided trekking adventure in Russia''s Altai Mountains was an unforgettable experience. The scenery was breathtaking, and our guide was very knowledgeable.', 30, 16),
(30, 'Margi', 'The eco-tour of Clearwater was fantastic! The mangrove forests were stunning, and we saw so much wildlife.', 23, 10),
(31, 'Almeda', 'The riverboat cruise along Myanmar''s Irrawaddy River was magical. The ancient temples in Bagan were awe-inspiring, and the encounters with local artisans were memorable.', 45, 14),
(32, 'Florence', 'The cultural immersion in China''s Longmen was fascinating. The UNESCO sites were impressive, and the traditional Chinese painting class was enjoyable.', 14, 4),
(33, 'Terrel', 'Exploring China''s Zhonghouhe was a cultural experience. The Ming Dynasty fortresses were impressive, and the encounters with local Daoist monks were enlightening.', 47, 9),
(34, 'Vickie', 'The tour of Sweden''s Östersund was fantastic. The guided hikes were exhilarating, and the fishing excursions were enjoyable.', 29, 25),
(35, 'Glennis', 'The eco-tour of Clearwater was absolutely amazing! The mangrove forests were stunning, and we saw so much wildlife. Highly recommend it!', 23, 14),
(36, 'Elianore', 'The charm of France''s Saint-Leu-la-Forêt was irresistible. The historic chateaus were stunning, and the wine tastings were delightful.', 44, 3),
(37, 'Aindrea', 'The guided trekking adventure in Russia''s Altai Mountains was an unforgettable experience. The scenery was breathtaking, and our guide was very knowledgeable.', 10, 23),
(38, 'Ethelin', 'The guided tour of Switzerland''s Bern was amazing. The hiking tours were breathtaking, and the visits to alpine villages were charming.', 21, 28),
(39, 'Goraud', 'Exploring India''s Manali was an adventure. The hikes through the Himalayas were beautiful, and we even saw some wildlife.', 6, 8),
(40, 'Reynard', 'The charm of France''s Saint-Leu-la-Forêt was irresistible. The historic chateaus were stunning, and the wine tastings were delightful.', 44, 16),
(41, 'Sunny', 'The cultural immersion in China''s Lincheng was eye-opening. The UNESCO sites were impressive, and interacting with local craftsmen was a highlight.', 20, 16),
(42, 'Leann', 'The tour of Sweden''s Östersund was fantastic. The guided hikes were exhilarating, and the fishing excursions were enjoyable.', 25, 14),
(43, 'Donalt', 'The island-hopping tour in the Philippines was amazing. Each island had its own unique beauty, and the snorkeling was fantastic.', 16, 11),
(44, 'Kerrie', 'Exploring China''s Zhonghouhe was a cultural experience. The Ming Dynasty fortresses were impressive, and the encounters with local Daoist monks were enlightening.', 47, 3),
(45, 'Shae', 'Exploring Russia''s Caucasus Mountains was an adventure of a lifetime! The hikes through alpine meadows were beautiful, and we even spotted some wildlife.', 32, 26),
(46, 'Siward', 'The tour of Portugal''s Aveiro region was wonderful. The historic canals were picturesque, and the local delicacies were delicious.', 39, 3),
(47, 'Tedmund', 'Exploring Brazil''s Salgado was a thrilling adventure. The guided jungle treks were exhilarating, and the encounters with indigenous tribes were eye-opening.', 37, 8),
(48, 'Hilly', 'The cultural immersion in China''s Longmen was fascinating. The UNESCO sites were impressive, and the traditional Chinese painting class was enjoyable.', 49, 3),
(49, 'Annabal', 'The tour of Portugal''s Aveiro region was fantastic. The boat rides were scenic, and the tastings of local delicacies were delicious.', 39, 3),
(50, 'Stesha', 'The guided trekking adventure in Russia''s Altai Mountains was unforgettable. The scenery was breathtaking, and our guide was very knowledgeable.', 14, 22);

-- Sample data for AdLiaison table

INSERT INTO AdLiaison (LiaisonID, first_name, last_name, email) VALUES
(1, 'Paulette', 'Dandy', 'pdandy0@so-net.ne.jp'),
(2, 'Loraine', 'Gudgion', 'lgudgion1@forbes.com'),
(3, 'Adam', 'Dever', 'adever2@miibeian.gov.cn'),
(4, 'Jeanette', 'Radage', 'jradage3@tmall.com'),
(5, 'Adey', 'Hasell', 'ahasell4@clickbank.net'),
(6, 'Phillis', 'Case', 'pcase5@symantec.com'),
(7, 'Merwyn', 'Siggers', 'msiggers6@github.com'),
(8, 'Rick', 'McClinton', 'rmcclinton7@nydailynews.com'),
(9, 'Joell', 'Bewly', 'jbewly8@howstuffworks.com'),
(10, 'Fiann', 'Dulson', 'fdulson9@weibo.com'),
(11, 'Vassily', 'Talbot', 'vtalbota@cisco.com'),
(12, 'Fae', 'Jarvie', 'fjarvieb@vimeo.com'),
(13, 'Wolfgang', 'Try', 'wtryc@csmonitor.com'),
(14, 'Hermione', 'Harhoff', 'hharhoffd@phoca.cz'),
(15, 'Yuri', 'Guilford', 'yguilforde@dailymotion.com'),
(16, 'Tommi', 'Paaso', 'tpaasof@google.it'),
(17, 'Alexio', 'Guillond', 'aguillondg@samsung.com'),
(18, 'Clarette', 'Stanney', 'cstanneyh@comcast.net'),
(19, 'Kristin', 'Riep', 'kriepi@chron.com'),
(20, 'Cassandry', 'Alliott', 'calliottj@goo.ne.jp'),
(21, 'Cortie', 'Blackboro', 'cblackborok@google.fr'),
(22, 'Flossi', 'Baukham', 'fbaukhaml@blogspot.com'),
(23, 'Lurette', 'A''Barrow', 'labarrowm@so-net.ne.jp'),
(24, 'Tami', 'Santostefano.', 'tsantostefanon@army.mil'),
(25, 'Tessy', 'Marner', 'tmarnero@miibeian.gov.cn'),
(26, 'Saudra', 'Gallico', 'sgallicop@rediff.com'),
(27, 'Kendricks', 'Darrell', 'kdarrellq@dmoz.org'),
(28, 'Haleigh', 'Hasely', 'hhaselyr@mapy.cz'),
(29, 'Lonnie', 'Sorrill', 'lsorrills@biglobe.ne.jp'),
(30, 'Garrot', 'Keane', 'gkeanet@quantcast.com'),
(31, 'Lorettalorna', 'Inder', 'linderu@cdbaby.com'),
(32, 'Felix', 'McCurt', 'fmccurtv@webnode.com'),
(33, 'Isaac', 'Straughan', 'istraughanw@guardian.co.uk'),
(34, 'Burl', 'Farndale', 'bfarndalex@edublogs.org'),
(35, 'Karoly', 'Boyde', 'kboydey@mediafire.com'),
(36, 'Harli', 'Yitzhakov', 'hyitzhakovz@marketwatch.com'),
(37, 'Albina', 'Coplestone', 'acoplestone10@fotki.com'),
(38, 'Veradis', 'Langstone', 'vlangstone11@yahoo.com'),
(39, 'Toiboid', 'Kewzick', 'tkewzick12@ft.com'),
(40, 'Wilbert', 'Greatbanks', 'wgreatbanks13@angelfire.com'),
(41, 'Concettina', 'Petican', 'cpetican14@bing.com'),
(42, 'Mathias', 'Hargrove', 'mhargrove15@go.com'),
(43, 'Lukas', 'Calverley', 'lcalverley16@stumbleupon.com'),
(44, 'Geoff', 'Jackett', 'gjackett17@wiley.com'),
(45, 'Amberly', 'Deniskevich', 'adeniskevich18@google.ru'),
(46, 'Bondon', 'Kill', 'bkill19@nationalgeographic.com'),
(47, 'Darcee', 'Murrigans', 'dmurrigans1a@simplemachines.org'),
(48, 'Jeanna', 'Gowrie', 'jgowrie1b@answers.com'),
(49, 'Pierson', 'Capon', 'pcapon1c@clickbank.net'),
(50, 'Lydie', 'Bartoszewicz', 'lbartoszewicz1d@drupal.org');

-- Sample data for Advertiser table

INSERT INTO Advertiser (AdvertiserID, first_name, last_name, CompanyName, email, package, LiaisonID) VALUES
(1, 'Mathew', 'Guillotin', 'Smitham Inc', 'mguillotin0@jigsy.com', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 33),
(2, 'Woody', 'Hessel', 'Durgan Group', 'whessel1@google.com.au', 'Standard package: Basic advertising services with limited customization and analytics.', 47),
(3, 'Lawrence', 'Lyndon', 'Powlowski-Ratke', 'llyndon2@illinois.edu', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 44),
(4, 'Pandora', 'Kitchenman', 'Heathcote-Cassin', 'pkitchenman3@mozilla.org', 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 15),
(5, 'Carrissa', 'McCahey', 'Ferry Group', 'cmccahey4@weibo.com', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 41),
(6, 'Guthry', 'Bovey', 'Greenholt, Balistreri and Mann', 'gbovey5@forbes.com', 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 21),
(7, 'Chery', 'Heritege', 'Hessel-Weber', 'cheritege6@hc360.com', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 38),
(8, 'Thia', 'Maleney', 'Schamberger Inc', 'tmaleney7@bandcamp.com', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 44),
(9, 'Rriocard', 'Tichner', 'Hirthe Group', 'rtichner8@bbb.org', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 10),
(10, 'Kathe', 'Wimsett', 'Rath-Funk', 'kwimsett9@xinhuanet.com', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 33),
(11, 'Aveline', 'Tunny', 'King-Hammes', 'atunnya@live.com', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 38),
(12, 'Dannye', 'McKinnell', 'Nolan Inc', 'dmckinnellb@yahoo.co.jp', 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 23),
(13, 'Frayda', 'Blachford', 'Krajcik-Okuneva', 'fblachfordc@rediff.com', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 13),
(14, 'Jessalin', 'Kilbee', 'Mayer LLC', 'jkilbeed@geocities.jp', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 7),
(15, 'Alano', 'Challender', 'Wisozk-Roberts', 'achallendere@timesonline.co.uk', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 19),
(16, 'Inness', 'Cowtherd', 'D''Amore-Denesik', 'icowtherdf@ustream.tv', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 9),
(17, 'Gertie', 'Tixall', 'Lind Inc', 'gtixallg@shutterfly.com', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 18),
(18, 'Ricky', 'Barrowcliff', 'Kovacek Inc', 'rbarrowcliffh@seesaa.net', 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 27),
(19, 'Ianthe', 'Pougher', 'Gislason-Bruen', 'ipougheri@reverbnation.com', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 10),
(20, 'Ramona', 'Hilldrup', 'Doyle-Hackett', 'rhilldrupj@comsenz.com', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 44),
(21, 'Vida', 'Orro', 'Gorczany-Sawayn', 'vorrok@e-recht24.de', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 50),
(22, 'Elihu', 'Crampton', 'Beahan Inc', 'ecramptonl@fastcompany.com', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 45),
(23, 'Carolann', 'Aujouanet', 'Renner, Cole and Collier', 'caujouanetm@cpanel.net', 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 4),
(24, 'Pepito', 'Busher', 'Mitchell, Goldner and Mitchell', 'pbushern@google.fr', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 29),
(25, 'Leonid', 'Langstone', 'Orn-Quigley', 'llangstoneo@themeforest.net', 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 46),
(26, 'Wenona', 'Hackelton', 'Brekke and Sons', 'whackeltonp@surveymonkey.com', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 50),
(27, 'Cherry', 'Studholme', 'Koch and Sons', 'cstudholmeq@newyorker.com', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 31),
(28, 'Claudelle', 'Kearey', 'Koelpin, Fisher and Waters', 'ckeareyr@eepurl.com', 'Standard package: Basic advertising services with limited customization and analytics.', 7),
(29, 'Roselle', 'Barrowcliff', 'Swift and Sons', 'rbarrowcliffs@google.es', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 39),
(30, 'Meridel', 'Eyton', 'Nitzsche Inc', 'meytont@wiley.com', 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 44),
(31, 'Vivie', 'Gadesby', 'Monahan Inc', 'vgadesbyu@wikispaces.com', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 48),
(32, 'Rosene', 'McCurtain', 'O''Kon-Runte', 'rmccurtainv@opera.com', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 3),
(33, 'Basilius', 'Lorant', 'Aufderhar-Purdy', 'blorantw@salon.com', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 12),
(34, 'Lind', 'Duckels', 'Spinka-Purdy', 'lduckelsx@issuu.com', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 46),
(35, 'Rustin', 'Bensley', 'Ferry, Harber and Crooks', 'rbensleyy@aboutads.info', 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 45),
(36, 'Cordell', 'Dunk', 'Cummings, Durgan and Wilkinson', 'cdunkz@cmu.edu', 'Standard package: Basic advertising services with limited customization and analytics.', 16),
(37, 'Hamel', 'Atkyns', 'Renner, Walker and Toy', 'hatkyns10@hatena.ne.jp', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 32),
(38, 'Dillie', 'Woodeson', 'Jakubowski Group', 'dwoodeson11@jugem.jp', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 25),
(39, 'Patsy', 'MacPhee', 'Rice-Bahringer', 'pmacphee12@soup.io', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 24),
(40, 'Cordey', 'Scarlon', 'Hodkiewicz and Sons', 'cscarlon13@miitbeian.gov.cn', 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 50),
(41, 'Sarajane', 'Rentcome', 'Smitham and Sons', 'srentcome14@yellowpages.com', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 15),
(42, 'Kerwin', 'Guite', 'Turner Inc', 'kguite15@nasa.gov', 'Standard package: Basic advertising services with limited customization and analytics.', 14),
(43, 'Jess', 'Tabary', 'Stroman, Conroy and Franecki', 'jtabary16@accuweather.com', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 16),
(44, 'Bell', 'Pickerin', 'Williamson-Beer', 'bpickerin17@vk.com', 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 44),
(45, 'Phedra', 'Halvosen', 'Rolfson, Greenfelder and Streich', 'phalvosen18@ucsd.edu', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 10),
(46, 'Ricard', 'Guilloux', 'Gusikowski, Dicki and Leannon', 'rguilloux19@about.me', 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 39),
(47, 'Maryl', 'Kedward', 'Nitzsche, Christiansen and Bartell', 'mkedward1a@cargocollective.com', 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 34),
(48, 'Lenette', 'Trewinnard', 'Schinner-Howell', 'ltrewinnard1b@msu.edu', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 34),
(49, 'Ronnie', 'Revill', 'Dare, Durgan and Schowalter', 'rrevill1c@hibu.com', 'Starter package: Entry-level advertising solutions for small businesses and startups.', 34),
(50, 'Maynard', 'Brimner', 'Wintheiser, Schmeler and Bauch', 'mbrimner1d@a8.net', 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 46);


-- Sample data for Experience_Ads table

INSERT INTO Experience_Ads (ExID, package, ProviderID, AdvertiserID) VALUES
(1, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 16, 3),
(2, 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 41, 40),
(3, 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 23, 14),
(4, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 27, 21),
(5, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 1, 5),
(6, 'Standard package: Basic advertising services with limited customization and analytics.', 17, 27),
(7, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 32, 8),
(8, 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 8, 50),
(9, 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 31, 20),
(10, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 16, 44),
(11, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 40, 41),
(12, 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 15, 33),
(13, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 43, 32),
(14, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 32, 38),
(15, 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 18, 1),
(16, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 16, 17),
(17, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 46, 9),
(18, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 9, 38),
(19, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 24, 19),
(20, 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 50, 8),
(21, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 14, 46),
(22, 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 38, 9),
(23, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 20, 41),
(24, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 17, 7),
(25, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 48, 23),
(26, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 31, 34),
(27, 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 43, 25),
(28, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 9, 41),
(29, 'Standard package: Basic advertising services with limited customization and analytics.', 7, 27),
(30, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 26, 37),
(31, 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 12, 28),
(32, 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 50, 36),
(33, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 38, 7),
(34, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 15, 32),
(35, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 6, 9),
(36, 'Standard package: Basic advertising services with limited customization and analytics.', 22, 31),
(37, 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 12, 4),
(38, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 21, 23),
(39, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 12, 44),
(40, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 15, 35),
(41, 'Premium package: Full marketing suite including social media management, targeted advertising, and analytics tools.', 36, 46),
(42, 'Standard package: Basic advertising services with limited customization and analytics.', 43, 11),
(43, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 45, 8),
(44, 'Premium Plus package: Comprehensive marketing strategy with advanced targeting options and dedicated account management.', 5, 3),
(45, 'Starter package: Entry-level advertising solutions for small businesses and startups.', 36, 1),
(46, 'Standard package: Basic advertising services with limited customization and analytics.', 7, 45),
(47, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 15, 39),
(48, 'Enterprise package: Scalable advertising solutions for large corporations and multinational companies.', 48, 16),
(49, 'Basic package: Essential advertising services for businesses looking to establish an online presence.', 50, 2),
(50, 'Custom package: Tailored advertising solutions designed to meet specific business objectives and budget requirements.', 7, 41);

-- Sample data for travel_Data table

INSERT INTO Travel_Data (TravelerID, PropertyID) VALUES
(2, 14),
(50, 19),
(13, 8),
(28, 15),
(40, 16),
(9, 17),
(24, 22),
(22, 10),
(47, 9),
(47, 21),
(13, 28),
(41, 5),
(9, 21),
(48, 19),
(22, 14),
(40, 26),
(8, 16),
(26, 5),
(25, 13),
(49, 23),
(48, 2),
(42, 28),
(34, 20),
(8, 22),
(49, 27),
(39, 25),
(13, 22),
(41, 5),
(22, 12),
(28, 14),
(35, 20),
(28, 1),
(25, 2),
(25, 15),
(15, 4),
(11, 4),
(43, 20),
(27, 12),
(3, 8),
(29, 22),
(17, 23),
(23, 9),
(41, 17),
(44, 3),
(28, 2),
(34, 2),
(12, 21),
(18, 26),
(24, 4),
(25, 7);

-- Sample data for property_data table

INSERT INTO Property_Data (AdvertiserID, PropertyID) VALUES
(2, 28),
(47, 14),
(40, 16),
(42, 25),
(12, 25),
(14, 3),
(39, 22),
(8, 27),
(24, 6),
(29, 28),
(11, 23),
(22, 20),
(11, 6),
(19, 27),
(31, 15),
(49, 7),
(4, 30),
(14, 17),
(4, 1),
(50, 12),
(30, 19),
(42, 21),
(13, 13),
(43, 13),
(34, 4),
(46, 23),
(3, 15),
(26, 12),
(5, 12),
(47, 8),
(42, 2),
(33, 1),
(1, 1),
(38, 13),
(4, 23),
(18, 28),
(45, 22),
(6, 6),
(1, 5),
(16, 8),
(45, 10),
(13, 18),
(24, 18),
(37, 9),
(33, 17),
(2, 13),
(10, 25),
(40, 5),
(45, 21),
(37, 23);

-- Sample data for Bundle table

INSERT INTO Bundle (BundleID, price, type, description) VALUES
(1, '$61.96', 'Travel', 'Weekend Getaway Package'),
(2, '$105.38', 'Travel', 'Family Vacation Package'),
(3, '$143.73', 'Entertainment', 'Movie Night Bundle'),
(4, '$76.22', 'Entertainment', 'Concert Experience Package'),
(5, '$124.57', 'Food', 'Date Night Dinner Package'),
(6, '$188.10', 'Food', 'Gourmet Dining Experience'),
(7, '$231.29', 'Travel', 'Luxury Resort Getaway'),
(8, '$105.74', 'Entertainment', 'VIP Event Access'),
(9, '$30.24', 'Food', 'Takeout Special'),
(10, '$149.19', 'Travel', 'Adventure Travel Bundle'),
(11, '$212.02', 'Entertainment', 'VIP Concert Passes'),
(12, '$123.45', 'Travel', 'City Sightseeing Tour'),
(13, '$41.74', 'Food', 'Brunch Buffet'),
(14, '$148.83', 'Entertainment', 'Theme Park Passes'),
(15, '$80.63', 'Entertainment', 'Live Show Tickets'),
(16, '$179.68', 'Travel', 'Beach Resort Package'),
(17, '$242.16', 'Travel', 'Cruise Vacation Package'),
(18, '$120.51', 'Food', 'Cooking Class Bundle'),
(19, '$135.83', 'Entertainment', 'Comedy Club Tickets'),
(20, '$238.37', 'Travel', 'Ski Resort Getaway'),
(21, '$220.60', 'Entertainment', 'Sports Event Tickets'),
(22, '$136.33', 'Food', 'Wine Tasting Experience'),
(23, '$31.45', 'Food', 'Pizza Night Special'),
(24, '$158.20', 'Travel', 'Hiking Adventure Package'),
(25, '$29.59', 'Food', 'Ice Cream Sundae Kit'),
(26, '$214.64', 'Travel', 'European Vacation Package'),
(27, '$53.15', 'Entertainment', 'Museum Passes'),
(28, '$182.49', 'Travel', 'National Park Tour'),
(29, '$129.32', 'Entertainment', 'Arcade Game Passes'),
(30, '$165.02', 'Food', 'Fine Dining Voucher'),
(31, '$85.73', 'Entertainment', 'Concert & Dinner Combo'),
(32, '$45.66', 'Food', 'Barbecue Party Pack'),
(33, '$33.21', 'Entertainment', 'Escape Room Experience'),
(34, '$74.94', 'Travel', 'Road Trip Essentials Bundle'),
(35, '$200.45', 'Entertainment', 'VIP Club Access'),
(36, '$210.82', 'Travel', 'All-Inclusive Resort Package'),
(37, '$215.41', 'Entertainment', 'Broadway Show Tickets'),
(38, '$244.21', 'Travel', 'Cultural Immersion Tour'),
(39, '$178.73', 'Food', 'Cooking Ingredients Bundle'),
(40, '$243.29', 'Entertainment', 'Music Festival Passes'),
(41, '$155.16', 'Travel', 'Wine Country Escape'),
(42, '$159.66', 'Entertainment', 'Art Gallery Passes'),
(43, '$107.05', 'Food', 'Dinner Party Kit'),
(44, '$248.82', 'Travel', 'Tropical Island Getaway'),
(45, '$144.56', 'Entertainment', 'Outdoor Adventure Passes'),
(46, '$88.07', 'Food', 'Weeknight Meal Subscription'),
(47, '$88.31', 'Food', 'Gourmet Cooking Ingredients'),
(48, '$208.25', 'Entertainment', 'VIP Theater Experience'),
(49, '$124.68', 'Travel', 'Safari Adventure Package'),
(50, '$177.02', 'Entertainment', 'Virtual Reality Gaming Bundle');


-- Sample data for Experience table

INSERT INTO Experience (ExperienceID, date, BundleID, TravelerID) VALUES
(1, '6/9/2023', 6, 1),
(2, '12/7/2023', 17, 2),
(3, '2/11/2024', 18, 18),
(4, '5/25/2023', 19, 3),
(5, '8/18/2023', 22, 1),
(6, '5/4/2023', 49, 3),
(7, '7/24/2023', 44, 7),
(8, '6/6/2023', 41, 28),
(9, '6/22/2023', 9, 17),
(10, '6/18/2023', 42, 4),
(11, '2/17/2024', 46, 26),
(12, '10/1/2023', 14, 14),
(13, '5/20/2023', 1, 14),
(14, '4/21/2023', 43, 6),
(15, '6/9/2023', 21, 5),
(16, '9/9/2023', 34, 18),
(17, '9/5/2023', 23, 4),
(18, '1/18/2024', 33, 29),
(19, '9/30/2023', 18, 24),
(20, '10/24/2023', 19, 14),
(21, '10/1/2023', 45, 27),
(22, '5/22/2023', 21, 1),
(23, '5/5/2023', 20, 17),
(24, '5/6/2023', 45, 7),
(25, '12/5/2023', 30, 22),
(26, '5/17/2023', 34, 27),
(27, '4/17/2023', 33, 21),
(28, '1/11/2024', 15, 1),
(29, '8/26/2023', 4, 5),
(30, '3/31/2024', 16, 10),
(31, '8/21/2023', 13, 30),
(32, '5/13/2023', 2, 7),
(33, '7/31/2023', 36, 30),
(34, '10/9/2023', 27, 12),
(35, '10/12/2023', 17, 5),
(36, '5/6/2023', 7, 13),
(37, '4/23/2023', 23, 29),
(38, '9/13/2023', 49, 11),
(39, '1/24/2024', 45, 27),
(40, '1/23/2024', 9, 14),
(41, '10/21/2023', 22, 18),
(42, '11/21/2023', 7, 12),
(43, '12/12/2023', 40, 4),
(44, '5/13/2023', 16, 23),
(45, '7/2/2023', 4, 1),
(46, '1/18/2024', 19, 4),
(47, '6/8/2023', 41, 5),
(48, '3/27/2024', 21, 14),
(49, '11/22/2023', 27, 27),
(50, '1/20/2024', 48, 23);


-- Sample data for Offer table

INSERT INTO Offer (BundleID, ProviderID) VALUES
(40, 38),
(17, 37),
(29, 5),
(22, 33),
(16, 45),
(26, 22),
(4, 33),
(7, 32),
(42, 21),
(7, 38),
(31, 20),
(45, 19),
(31, 46),
(27, 43),
(24, 12),
(18, 44),
(36, 28),
(27, 28),
(33, 38),
(17, 13),
(46, 6),
(31, 41),
(17, 42),
(1, 16),
(16, 31),
(26, 23),
(14, 39),
(19, 46),
(17, 5),
(6, 15),
(24, 43),
(5, 35),
(42, 7),
(17, 40),
(50, 19),
(14, 32),
(49, 15),
(3, 34),
(46, 19),
(50, 30),
(50, 30),
(22, 44),
(29, 8),
(3, 36),
(40, 17),
(37, 34),
(6, 18),
(1, 38),
(47, 20),
(44, 36);

































