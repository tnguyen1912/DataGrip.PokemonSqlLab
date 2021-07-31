#What are all the primary types and how many pokemon have that type?
SELECT COUNT(pokemons.name) AS '# Pokemons', types.name AS 'Primary Type' 
FROM pokemons
INNER JOIN types 
ON pokemons.primary_type = types.id 
GROUP BY pokemons.primary_type;