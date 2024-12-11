/* 
SQL Join query exercise

World database layout:
To use this database from a default MySQL install, type: use world;

Table: City
Columns: Id, Name, CountryCode, District, Population

Table: Country
Columns: Code, Name, Continent, Region, SurfaceArea, IndepYear, Population, LifeExpectancy, GNP, Capital

Table: CountryLanguage
Columns: CountryCode, Language, IsOfficial, Percentage
*/

-- 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM city WHERE Name LIKE "ping%"  ORDER BY Population ASC ;

-- 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM city WHERE Name LIKE "ran%"  ORDER BY Population DESC ;




-- 3: Count all cities
    SELECT COUNT(*) FROM city;


-- 4: Get the average population of all cities

    SELECT AVG(Population) FROM city;




-- 5: Get the biggest population found in any of the cities

    SELECT MAX(Population) FROM city;




-- 6: Get the smallest population found in any of the cities

    SELECT MIN(Population) FROM city;


-- 7: Sum the population of all cities with a population below 10000

    SELECT SUM(Population) FROM city;


-- 8: Count the cities with the country codes MOZ and VNM

    SELECT COUNT(*) FROM city WHERE CountryCode IN ("MOZ","VNM");


-- 9: Get individual count of cities for the country codes MOZ and VNM

SELECT COUNT(*) FROM city WHERE CountryCode IN ("MOZ","VNM") GROUP BY CountryCode;


-- 10: Get average population of cities in MOZ and VNM

    SELECT AVG(Population) FROM city WHERE CountryCode IN ("MOZ","VNM");


-- 11: Get the country codes with more than 200 cities

    SELECT CountryCode FROM city GROUP BY CountryCode HAVING COUNT(*) > 200;


-- 12: Get the country codes with more than 200 cities ordered by city count
    SELECT CountryCode, COUNT(*) AS CityCount FROM city GROUP BY CountryCode HAVING CityCount > 200 ORDER BY CityCount DESC ;



-- 13: What language(s) is spoken in the city with a population between 400 and 500?

SELECT * FROM countrylanguage;
SELECT * FROM country;
SELECT * FROM city;








-- 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
    SELECT city.name AS CityName, countrylanguage.language FROM city
        JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
                                                           WHERE city.Population BETWEEN 500 and 600;


-- 15: What names of the cities are in the same country as the city with a population of 122199 (including that city itself)
SELECT name FROM city
WHERE CountryCode = (SELECT CountryCode FROM city WHERE population = 122199);


-- 16: What names of the cities are in the same country as the city with a population of 122199 (excluding that city itself)
SELECT name FROM city
WHERE CountryCode = (SELECT CountryCode FROM city WHERE population = 122199)
  AND population != 122199;

-- 17: What are the city names in the country where Luanda is the capital?
SELECT * FROM countrylanguage;
SELECT * FROM country;
SELECT * FROM city;

SELECT city.name AS Cities FROM city
JOIN country
ON city.CountryCode = country.Code
WHERE country.Capital = (SELECT Id FROM city WHERE name = "Luanda");


-- 18: What are the names of the capital cities in countries in the same region as the city named Yaren

SELECT * FROM countrylanguage;
SELECT * FROM country;
SELECT * FROM city;

SELECT city.name AS Capitals FROM city
JOIN country
ON city.id = country.Capital
WHERE country.Region =
      (SELECT Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name = "Yaren");




-- 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT * FROM countrylanguage;
SELECT * FROM country;
SELECT * FROM city;

SELECT DISTINCT countrylanguage.Language FROM countrylanguage
JOIN country ON countrylanguage.CountryCode = country.Code
WHERE country.Region = (
    SELECT Region FROM city
JOIN country ON city.CountryCode = country.Code
    WHERE city.Name = "Riga"
);



-- 20: Get the name of the most populous city

SELECT name FROM city
WHERE population = (SELECT MAX(population) FROM city);



