# MySQL Pokemon Report Queries

### Goals
* Become proficient selecting data out of a mysql database
* Become comfortable performing a SQL join
* Be able to format SQL output as a readable report

## Instructions

### Part 1: Importing data
Directions:

* In DataGrip, [connect to your local mysql instance](https://www.jetbrains.com/help/idea/connecting-to-a-database.html#mysql)
**(for those not using DataGrip, you can execute the files in the command line, using the following syntax: ```mysql -u your_mysql_user -p < the_name_of_the_file.sql```)
* Create your pokemon schema
* Unpack the pokemon_sql.zip files
* One by one execute these files making sure to check your pokemon schema

From here you should have all the pokemon data in your mysql schema. Feel free to explore the data and perform a few select statements to see what the data looks like.

### Part 2: Simple Selects and Counts

Directions: Write a sql query or sql queries that can answer the following questions

* What are all the types of pokemon that a pokemon can have?
SELECT name FROM types;
* What is the name of the pokemon with id 45?
SELECT name FROM pokemons WHERE Id = 45;
* How many pokemon are there?
SELECT COUNT(id) FROM pokemons;
* How many types are there?
SELECT COUNT(name) FROM types;
* How many pokemon have a secondary type?
SELECT COUNT(id) FROM pokemons WHERE secondary_type IS NOT NULL;

### Part 3: Joins and Groups
Directions: Write a sql query or sql queries that can answer the following questions


* What is each pokemon's primary type?
SELECT pokemons.name AS Pokemon_Name, types.name AS Primary_Type 
FROM pokemons 
INNER JOIN types 
ON pokemons.primary_type = types.id;

* What is Rufflet's secondary type?
SELECT pokemons.name AS Pokemon_Name, types.name AS Secondary_Type 
FROM pokemons 
INNER JOIN types ON pokemons.secondary_type = types.id 
WHERE pokemons.name LIKE 'Rufflet';
//Flying

* What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT trainerID, pokemons.name AS 'Pokemon Name' 
FROM pokemon_trainer 
INNER JOIN pokemons
ON  pokemon_trainer.pokemon_id = pokemons.id 
WHERE pokemon_trainer.trainerID 
LIKE '303';

* How many pokemon have a secondary type `Poison`
SELECT COUNT(name) AS '#Pokemons With Poison Secondary' FROM pokemons WHERE secondary_type LIKE '7';

* What are all the primary types and how many pokemon have that type?
SELECT COUNT(pokemons.name) AS '# Pokemons', types.name AS 'Primary Type' 
FROM pokemons
INNER JOIN types 
ON pokemons.primary_type = types.id 
GROUP BY pokemons.primary_type;

* How many pokemon at level 100 does each trainer with at least one level 100 pokemon have? (Hint: your query should not display a trainer)

SELECT DISTINCT(trainers.trainername) AS 'Trainers Name', COUNT(*) AS '# lvl 100 Pokemon' 
FROM trainers
INNER JOIN pokemon_trainer 
ON pokemon_trainer.trainerID = trainers.trainerID 
WHERE pokelevel > 99 
GROUP BY pokemon_trainer.trainerID 
ORDER BY COUNT(*) DESC;

* How many pokemon only belong to one trainer and no other?

SELECT COUNT(*) AS '#People Who Caught This Pokemon', pokemons.name AS "Pokemon"
FROM pokemon_trainer 
INNER JOIN pokemons
ON pokemon_trainer.pokemon_id = pokemons.id
GROUP BY pokemon_id
HAVING COUNT(*) = 1;

### Part 4: Final Report

Directions: Write a query that returns the following collumns:

| Pokemon Name | Trainer Name | Level | Primary Type | Secondary Type |
|:------------:|:------------:|:-----:|:------------:|:--------------:|
| Pokemon's name| Trainer's name| Current Level| Primary Type Name| Secondary Type Name|

Sort the data by finding out which trainer has the strongest pokemon so that this will act as a ranking of strongest to weakest trainer. You may interpret strongest in whatever way you want, but you will have to explain your decision.

SELECT 
DISTINCT(pokemon_trainer.pokemon_id) AS 'Pokemon Name',  
pokemon_trainer.trainerID AS 'Trainer Name', 
pokemon_trainer.pokelevel AS 'Level', 
pokemons.primary_type AS 'Primary Type', 
pokemons.secondary_type AS 'Secondary Type'  
FROM pokemon_trainer  
INNER JOIN pokemons  
ON pokemon_trainer.pokemon_id = pokemons.id
ORDER BY pokemon_id DESC
;


SELECT 
pokemon_trainer.pokemon_id AS 'Pokemon Name',  
pokemon_trainer.trainerID AS 'Trainer Name', 
pokemon_trainer.pokelevel AS 'Level', 
pokemons.primary_type AS 'Primary Type', 
pokemons.secondary_type AS 'Secondary Type'  
FROM pokemon_trainer  
INNER JOIN pokemons  
ON pokemon_trainer.pokemon_id = pokemons.id;


## Turning in this assignment

To turn in this assignment, create files for each part with at least one query for each question answered. Above each query include a comment with the question you were answering. The files should have the extension `.sql`
Example: 

```SQL
 # How many characters are in the string 'Hello World!'
 SELECT CHAR_LENGTH('Hello World!') AS length_of_hello_world
```

For Part 4 specifically also leave a comment explaining how your query is deciding who the strongest trainer is

Once all of that is done, submit your file by saving it in the "answers" directory and commititing it to your fork.
