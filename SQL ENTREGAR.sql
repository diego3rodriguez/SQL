
--1.Esquema BBDD
--2. Nombres de todas las películas con una clasificación por edades de `R`
SELECT "title"
FROM "film"
WHERE "rating" = 'R';

--3. Nombres de los actores que tengan un “actor_idˮ entre 30 y 40
SELECT "first_name", "last_name"
FROM "actor"
WHERE "actor_id" BETWEEN 30 AND 40;
--------
SELECT *
FROM film ;

--4. Películas cuyo idioma coincide con el idioma original
SELECT "title"
FROM "film"
WHERE "language_id" = "original_language_id";

--5. Películas por duración de forma ascendente
SELECT "title", "length"
FROM "film"
ORDER BY "length" ASC;

--6.  Nombre y apellido de los actores que tengan ‘Allenʼ en su apellido
SELECT *
FROM actor ;

SELECT "first_name", "last_name"
FROM "actor"
WHERE "last_name" = 'ALLEN';

--7.  Cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento
SELECT *
from "film" ;

SELECT "rating", COUNT(*) as cantidad_peliculas
FROM "film"
GROUP BY "rating";

--8.  Título de todas las películas que son ‘PG13ʼ o tienen una  duración mayor a 3 horas en la tabla film

SELECT "title"
FROM "film"
WHERE "rating" = 'PG-13' OR length > 180;

--9. Variabilidad de lo que costaría reemplazar las películas

SELECT "VARIANCE"(replacement_cost) as variabilidad
FROM film;

--10. Mayor y menor duración de una película

SELECT title, length as minutos
FROM film
ORDER BY length ASC
LIMIT 1; 

SELECT title, length as minutos
FROM film
ORDER BY length DESC
LIMIT 1;

--11.  Precio del antepenúltimo alquiler ordenado por día
SELECT amount
FROM payment
ORDER BY payment_date DESC
LIMIT 1 OFFSET 2;

--12.  Título de las películas en la tabla “filmˮ que no sean ni ‘NC17ʼ ni ‘Gʼ en cuanto a su clasificación
SELECT title
FROM film
WHERE rating NOT IN ('NC-17', 'G');

--13.  Promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el  promedio de duración
SELECT rating, AVG(length) as promedio_duracion
FROM film
GROUP BY rating;

--14. Título de todas las películas que tengan una duración mayor a 180 minutos
SELECT title
FROM film
WHERE length > 180;

--15. Dinero total generado por la empresa
SELECT SUM(amount) as total_generado
FROM payment;

--16. 10 Clientes con mayor valor id
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

--17. Nombre y apellidos de los actores que aparecen 
SELECT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
WHERE film.title = 'EGG IGBY';


--18. Nombres de las películas únicos
SELECT DISTINCT title
FROM film;

--19.  Título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ
SELECT film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND film.length > 180;

--20. Categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT category.name, AVG(film.length) as promedio_duracion
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
HAVING AVG(film.length) > 110;

--21. Media de duración del alquiler de las películas
SELECT AVG(rental_duration) as media_duracion_alquiler
FROM film;

--22. Nombre y apellidos de todos los actores y actrices
SELECT CONCAT(first_name, ' ', last_name) as nombre_completo
FROM actor;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente
SELECT DATE(rental_date) as dia, COUNT(*) as cantidad_alquileres
FROM rental
GROUP BY DATE(rental_date)
ORDER BY cantidad_alquileres DESC;

--24. Películas con una duración superior al promedio
SELECT AVG(length) as duracion_promedio
FROM film;

SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

--25. Número de alquileres registrados por mes
SELECT DATE_TRUNC('month', rental_date) as mes, COUNT(*) as cantidad_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date)
ORDER BY mes DESC;

--26. Promedio, la desviación estándar y varianza del total pagado
SELECT 
    AVG(amount) as promedio,
    STDDEV(amount) as desviacion_estandar,
    VARIANCE(amount) as varianza
FROM payment;

--27. Películas alquiladas por encima del precio medio
SELECT AVG(rental_rate) as precio_medio_alquiler
FROM film;

SELECT film.title, film.rental_rate
FROM film
WHERE film.rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY film.rental_rate DESC;

--28. Id de los actores que hayan participado en más de 40 películas
SELECT actor_id, COUNT(*) as cantidad_peliculas
FROM film_actor
GROUP BY actor_id
HAVING COUNT(*) > 40 ;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
SELECT 
    film.film_id,
    film.title,
    COUNT(inventory.inventory_id) as cantidad_disponible
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.film_id, film.title
ORDER BY film.title;

--30. Todos los actores y número de películas en las que han actuado
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) as numero_peliculas
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name ;

--31. Todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT 
    film.title,
    actor.first_name,
    actor.last_name
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
LEFT JOIN actor ON film_actor.actor_id = actor.actor_id
ORDER BY film.title, actor.last_name;

--32. Todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película
SELECT 
    actor.first_name,
    actor.last_name,
    film.title
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
LEFT JOIN film ON film_actor.film_id = film.film_id
ORDER BY actor.last_name, film.title;

--33. Todas las películas que tenemos y todos los registros de alquiler
SELECT 
    film.film_id,
    film.title,
    rental.rental_id,
    rental.rental_date,
    rental.return_date,
    customer.first_name,
    customer.last_name
from film
LEFT JOIN inventory ON film.film_id = inventory.film_id
LEFT JOIN rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN customer ON rental.customer_id = customer.customer_id
ORDER BY film.title, rental.rental_date DESC;

--34. 5 clientes que más dinero han gastado 
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) as total_gastado
FROM customer
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
LIMIT 5;

--35. Todos los actores cuyo primer nombre es Johnny
select *
from actor ;

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'JOHNNY';

--36.  Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
SELECT 
    first_name as Nombre,
    last_name as Apellido
FROM actor ;

--37.  Encuentra el ID del actor más bajo y más alto en la tabla actor
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id = (SELECT MIN(actor_id) FROM actor)
   OR actor_id = (SELECT MAX(actor_id) FROM actor);

--38. Cuántos actores hay en la tabla “actorˮ
SELECT COUNT(*) as total_actores
FROM actor;

--39. Todos los actores y ordenados por apellido en orden ascendente
SELECT actor_id, first_name, last_name
FROM actor
ORDER BY last_name ASC;

--40. 5 primeras películas de la tabla "film"
SELECT film_id, title
FROM film
LIMIT 5;

--41. Actores agrupados por su nombre y cuántos tienen el mismo nombre
SELECT first_name, COUNT(*) as cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;

--42. Todos los alquileres y los nombres de los clientes que los realizaron
SELECT 
    rental.rental_id,
    rental.rental_date,
    rental.return_date,
    customer.first_name,
    customer.last_name
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id ;

--43. Todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
SELECT 
    customer.first_name,
    customer.last_name,
    rental.rental_id,
    rental.rental_date,
    rental.return_date
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id ;

--44. SELECT film.title, category.name
SELECT film.title, category.name
FROM film
CROSS JOIN category; 

--No creo que aporte valor porque devuelve un listado enorme sin considerar las relaciones reales entre film y category, repitiendo cada película con todas las categorias. 

--45. Actores que han participado en las peliculas de categoria "Action"
SELECT DISTINCT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action';

--46. Actores que no han participado en películas 
SELECT COUNT(*) as total_actores
FROM actor;

SELECT COUNT(DISTINCT actor_id) as actores_con_peliculas
FROM film_actor;

--No hay actores que no hayan participado en películas

--47. Nombre de actores y cantidad de películas en las que han participado
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) as cantidad_peliculas
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name ;

--48. Vista "actor_num_peliculas" 
CREATE VIEW actor_num_peliculas AS
SELECT 
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) as numero_peliculas
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name;

SELECT * FROM actor_num_peliculas ;

--49. Número total de alquileres realizados por cada cliente
SELECT 
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_alquileres
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name ;

--50. Duración total de las películas en la categoria "Action"
SELECT SUM(film.length) AS duracion_total
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Action';

--51. Tabla temporal llamada "cliente_rentas_temporal" para almacenar el total de alquileres por cliente
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS total_alquileres
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name;

SELECT * FROM cliente_rentas_temporal;

--52. Tabla temporal llamada "peliculas_alquiladas" para almacenar las peliculas que han sido alquiladas al menos 10 veces
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT 
    film.film_id,
    film.title,
    COUNT(rental.rental_id) AS total_alquileres
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
HAVING COUNT(rental.rental_id) >= 10;

SELECT * FROM peliculas_alquiladas;

--53. Titulo de las películas que han sido alquiladas por "Tammy Sanders" y que aún no se han devuelto.
SELECT film.title
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.first_name = 'TAMMY'
  AND customer.last_name = 'SANDERS'
  AND rental.return_date IS NULL
ORDER BY film.title ASC;

--54. Nombres actores que han actuado en al menos una película de la categoria 'Sci-Fi'
SELECT DISTINCT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Sci-Fi'
ORDER BY actor.last_name ASC;

--55. Nombre y apellidos de los actores que han actuado en películas alquiladas despues de la primera vez que se alquiló "Spartacus Cheaper"

SELECT MIN(rental_date) AS primera_fecha_alquiler
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'SPARTACUS CHEAPER';


SELECT DISTINCT actor.first_name, actor.last_name
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE rental.rental_date > (
    SELECT MIN(rental_date)
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    WHERE film.title = 'SPARTACUS CHEAPER'
)
ORDER BY actor.last_name ASC;

--56. Actores que no han actuado en ninguna película de la categoria 'Music'
SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id NOT IN (
    SELECT DISTINCT actor.actor_id
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    JOIN film ON film_actor.film_id = film.film_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    WHERE category.name = 'Music'
);

--57. Películas que fueron alquiladas por más de 8 días
SELECT DISTINCT film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
WHERE 
    rental.return_date IS NOT NULL
    AND EXTRACT(DAY FROM (rental.return_date - rental.rental_date)) > 8
;

--58. Todas las películas que son de la misma categoria que "Animation"
SELECT DISTINCT film.title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Animation';

--59. Películas que tienen la misma duración que la película "Dancing Fever"
SELECT title
FROM film
WHERE length = (
    SELECT length
    FROM film
    WHERE title = 'DANCING FEVER'
)
ORDER BY title ASC;

--60. Clientes que han alquilado al menos 7 películas distintas
SELECT customer.first_name, customer.last_name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
HAVING COUNT(DISTINCT film.film_id) >= 7
ORDER BY customer.last_name ASC;

--61. Cantidad total de películas alquiladas por categoria
SELECT category.name AS categoria, COUNT(rental.rental_id) AS total_alquileres
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_alquileres DESC;

--62. Número de películas por categoria estrenadas en 2006
SELECT category.name AS categoria, COUNT(film.film_id) AS numero_peliculas
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE film.release_year = 2006
GROUP BY category.name
ORDER BY numero_peliculas DESC;

--63. Todas las combinaciones posibles de trabajadores con las tiendas que hay
SELECT staff.first_name, staff.last_name, store.store_id
FROM staff
CROSS JOIN store;

--64. Cantidad total de películas alquiladas por cada cliente
SELECT 
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS cantidad_alquiladas
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name ;




























