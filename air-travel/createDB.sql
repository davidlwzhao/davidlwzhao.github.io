/*
Update order is
1. Carriers, Airports
2. Routes
3. Quotes
*/

DROP TABLE IF EXISTS CARRIERS;
CREATE TABLE CARRIERS
(
    CarrierId    INTEGER     PRIMARY KEY,
    SkyScannerId INT     UNIQUE NOT NULL,
    Carrier      TEXT    NOT NULL
);


DROP TABLE IF EXISTS AIRPORTS;
CREATE TABLE AIRPORTS
(
    AirportId       INT     PRIMARY KEY,
    SkyScannerId    INT     UNIQUE NOT NULL,
    Airport         TEXT    NOT NULL,
    Country         TEXT    NOT NULL,
    City            TEXT,
    CityId          TEXT,
    IATA            CHAR(3) NOT NULL
);


DROP TABLE IF EXISTS ROUTES;
CREATE TABLE ROUTES
(
    RouteId         INT     PRIMARY KEY,
    OriginId        INT     NOT NULL,
    DestinationId   INT     NOT NULL,
    FOREIGN KEY (OriginId)
    REFERENCES AIRPORTS (SkyScannerId) 
       ON UPDATE CASCADE
       ON DELETE CASCADE, 

    FOREIGN KEY (DestinationId)
    REFERENCES AIRPORTS (SkyScannerId) 
       ON UPDATE CASCADE
       ON DELETE CASCADE
);


DROP TABLE IF EXISTS QUOTES;
CREATE TABLE QUOTES
(
    QuoteId             INT PRIMARY KEY,
    RouteId             INT NOT NULL,
    CarrierId           INT NOT NULL,
    QuoteQueryTime      DATETIME NOT NULL,
    QuoteCollectedTime  DATETIME NOT NULL,
    DepartureTime       DATETIME NOT NULL,
    ReturnTime          DATETIME NOT NULL,
    Price               FLOAT NOT NULL,
    Direct              INT NOT NULL,
    
    FOREIGN KEY (RouteId)
    REFERENCES ROUTES (RouteId) 
       ON UPDATE CASCADE
       ON DELETE CASCADE,

    FOREIGN KEY (CarrierId)
    REFERENCES CARRIERS (CarrierId) 
       ON UPDATE CASCADE
       ON DELETE CASCADE
);

/*
Debugging data entry

INSERT INTO CARRIERS (SkyScannerId, Carrier) 
VALUES
(1, "BA"),
(2, "BA2")
;

INSERT INTO AIRPORTS (SkyScannerId, Airport, Country, City, CityId, IATA) 
VALUES
(1, "Heathrow", "UK", "London", 1, "LHR"),
(2, "Gatwick", "UK", "London", 1, "GAT")
;

INSERT INTO ROUTES (OriginId, DestinationId)
VALUES
(1, 2)
;

INSERT INTO QUOTES (RouteID, CarrierId, QuoteQueryTime, QuoteCollectedTime, DepartureTime, ReturnTime, Price, Direct)
VALUES
(1, 2, "2014-09-30 20:24:02", "2014-09-30 20:24:02", "2014-09-30 20:24:02", "2014-09-30 20:24:02", 100.02, 0)
;
*/