/* 
1. Crea el esquema de la BBDD
*/
CREATE SCHEMA IF NOT EXISTS videoclub;

/* 
2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
*/
SELECT title
FROM film
WHERE rating = 'R';

/* 
3. Encuentra los nombres de los actores que tengan un actor_id entre 30 y 40.
*/
SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 30 AND 40;

/* 
4. Obtén las películas cuyo idioma coincide con el idioma original.
*/
SELECT title
FROM film
WHERE original_language_id = language_id
  AND original_language_id IS NOT NULL;

/* 
5. Ordena las películas por duración de forma ascendente.
*/
SELECT title, length
FROM film
ORDER BY length ASC;

/* 
6. Encuentra el nombre y apellido de los actores que tengan 'Allen' en su apellido.
*/
SELECT first_name, last_name
FROM actor
WHERE last_name ILIKE '%Allen%';

/* 
7. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
*/
SELECT rating, COUNT(*) AS total_peliculas
FROM film
GROUP BY rating
ORDER BY total_peliculas DESC;

/* 
8. Encuentra el título de todas las películas que son 'PG-13' o tienen una duración mayor a 180 minutos.
*/
SELECT title, rating, length
FROM film
WHERE rating = 'PG-13'
   OR length > 180;

/* 
9. Encuentra la variabilidad del replacement_cost de las películas.
*/
SELECT VARIANCE(replacement_cost) AS variabilidad_reemplazo
FROM film;

/* 
10. Encuentra la mayor y menor duración de una película.
*/
SELECT MAX(length) AS duracion_maxima,
       MIN(length) AS duracion_minima
FROM film;

/* 
11. Encuentra lo que costó el antepenúltimo alquiler ordenado por fecha.
*/
SELECT rental_id,
       rental_date
FROM rental
ORDER BY rental_date DESC
OFFSET 2 LIMIT 1;

/* 
12. Encuentra las películas que no sean ni 'NC-17' ni 'G'.
*/
SELECT title, rating
FROM film
WHERE rating NOT IN ('NC-17', 'G');

/* 
13. Encuentra el promedio de duración de las películas para cada clasificación.
*/
SELECT rating, AVG(length) AS promedio_duracion
FROM film
GROUP BY rating
ORDER BY promedio_duracion DESC;

/* 
14. Encuentra las películas con una duración mayor a 180 minutos.
*/
SELECT title, length
FROM film
WHERE length > 180
ORDER BY length DESC;

/* 
15. ¿Cuánto dinero ha generado en total la empresa?
*/
SELECT SUM(amount) AS total_generado
FROM payment;

/* 
16. Muestra los 10 clientes con mayor ID.
*/
SELECT customer_id, first_name, last_name
FROM customer
ORDER BY customer_id DESC
LIMIT 10;

/* 
17. Encuentra el nombre y apellido de los actores que aparecen en la película 'Egg Igby'.
*/
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'Egg Igby';

/* 
18. Selecciona todos los nombres de las películas únicos.
*/
SELECT DISTINCT title
FROM film
ORDER BY title ASC;

/* 
19. Encuentra las películas que son comedias y duran más de 180 minutos.
*/
SELECT f.title, f.length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Comedy'
  AND f.length > 180;

/* 
20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos.
*/
SELECT c.name AS categoria, AVG(f.length) AS promedio_duracion
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
HAVING AVG(f.length) > 110
ORDER BY promedio_duracion DESC;

/* 
21. ¿Cuál es la media de duración de los alquileres?
*/
SELECT AVG(return_date - rental_date) AS promedio_dias_alquiler
FROM rental
WHERE return_date IS NOT NULL;

/* 
22. Crea una columna con el nombre y apellidos de todos los actores.
*/
SELECT first_name,
       last_name,
       first_name || ' ' || last_name AS nombre_completo
FROM actor;

/* 
23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
*/
SELECT DATE(rental_date) AS dia,
       COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE(rental_date)
ORDER BY total_alquileres DESC;

/* 
24. Encuentra las películas con una duración superior al promedio.
*/
SELECT title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;

/* 
25. Averigua el número de alquileres registrados por mes.
*/
SELECT DATE_TRUNC('month', rental_date) AS mes,
       COUNT(*) AS total_alquileres
FROM rental
GROUP BY DATE_TRUNC('month', rental_date)
ORDER BY mes;

/* 
26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
*/
SELECT AVG(amount) AS promedio,
       STDDEV(amount) AS desviacion_estandar,
       VARIANCE(amount) AS varianza
FROM payment;

/* 
27. ¿Qué películas se alquilan por encima del precio medio?
*/
SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film)
ORDER BY rental_rate DESC;

/* 
28. Muestra el id de los actores que hayan participado en más de 40 películas.
*/
SELECT fa.actor_id,
       COUNT(fa.film_id) AS total_peliculas
FROM film_actor fa
GROUP BY fa.actor_id
HAVING COUNT(fa.film_id) > 40
ORDER BY total_peliculas DESC;

/* 
29. Obtener todas las películas y si están disponibles en el inventario, mostrar la cantidad disponible.
*/
SELECT f.title,
       COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i 
       ON f.film_id = i.film_id
LEFT JOIN rental r 
       ON i.inventory_id = r.inventory_id
       AND r.return_date IS NULL
WHERE r.rental_id IS NULL
GROUP BY f.title
ORDER BY cantidad_disponible DESC;

/* 
30. Obtener los actores y el número de películas en las que han actuado.
*/
SELECT a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS total_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY total_peliculas DESC;

/* 
31. Obtener todas las películas y mostrar los actores que han actuado en ellas.
*/
SELECT f.title,
       a.first_name,
       a.last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
LEFT JOIN actor a ON a.actor_id = fa.actor_id
ORDER BY f.title;

/* 
32. Obtener todos los actores y mostrar las películas en las que han actuado.
*/
SELECT a.first_name,
       a.last_name,
       f.title AS pelicula
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id
ORDER BY a.last_name, a.first_name;

/* 
33. Obtener todas las películas que tenemos y todos los registros de alquiler.
*/
SELECT f.title,
       r.rental_id,
       r.rental_date
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY f.title;

/* 
34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
*/
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       SUM(p.amount) AS total_gastado
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_gastado DESC
LIMIT 5;

/* 
35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
*/
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Johnny';

/* 
36. Renombra la columna first_name como Nombre y last_name como Apellido.
*/
SELECT first_name AS Nombre,
       last_name AS Apellido
FROM actor;

/* 
37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
*/
SELECT MIN(actor_id) AS id_minimo,
       MAX(actor_id) AS id_maximo
FROM actor;

/* 
38. Cuenta cuántos actores hay en la tabla actor.
*/
SELECT COUNT(*) AS total_actores
FROM actor;

/* 
39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
*/
SELECT first_name,
       last_name
FROM actor
ORDER BY last_name ASC;

/* 
40. Selecciona las primeras 5 películas de la tabla film.
*/
SELECT title
FROM film
LIMIT 5;

/* 
41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 
   ¿Cuál es el nombre más repetido?
*/
SELECT first_name,
       COUNT(*) AS cantidad
FROM actor
GROUP BY first_name
ORDER BY cantidad DESC;

/* 
42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
*/
SELECT r.rental_id,
       r.rental_date,
       c.first_name,
       c.last_name
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id;

/* 
43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
*/
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       r.rental_id,
       r.rental_date
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
ORDER BY c.customer_id;

/* 
44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué?
*/
SELECT f.title,
       c.name AS categoria
FROM film f
CROSS JOIN category c;
/* No aporta valor porque combina todas las películas con todas las categorías aunque no estén relacionadas. */

/* 
45. Encuentra los actores que han participado en películas de la categoría 'Action'.
*/
SELECT DISTINCT a.first_name,
                a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fa.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action'
ORDER BY a.last_name;

/* 
46. Encuentra todos los actores que no han participado en películas.
*/
SELECT a.first_name,
       a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL
ORDER BY a.last_name;

/* 
47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
*/
SELECT a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS total_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY total_peliculas DESC;

/* 
48. Crea una vista llamada actor_num_peliculas que muestre los nombres de los actores y el número de películas en las que han participado.
*/
CREATE OR REPLACE VIEW actor_num_peliculas AS
SELECT a.actor_id,
       a.first_name,
       a.last_name,
       COUNT(fa.film_id) AS total_peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id;

/* 
49. Calcula el número total de alquileres realizados por cada cliente.
*/
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_alquileres DESC;

/* 
50. Calcula la duración total de las películas en la categoría 'Action'.
*/
SELECT SUM(f.length) AS duracion_total
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Action';

/* 
51. Crea una tabla temporal llamada cliente_rentas_temporal.
*/
CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id;

/* 
52. Crea una tabla temporal llamada peliculas_alquiladas que almacene las películas que han sido alquiladas al menos 10 veces.
*/
CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id,
       f.title,
       COUNT(r.rental_id) AS total_alquileres
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id
HAVING COUNT(r.rental_id) >= 10;

/* 
53. Encuentra el título de las películas que han sido alquiladas por ‘Tammy Sanders’ y que aún no se han devuelto.
*/
SELECT DISTINCT f.title
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN customer c ON c.customer_id = r.customer_id
WHERE c.first_name = 'Tammy'
  AND c.last_name = 'Sanders'
  AND r.return_date IS NULL
ORDER BY f.title;

/* 
54. Encuentra los nombres de los actores que han actuado en al menos una película de la categoría ‘Sci-Fi’.
*/
SELECT DISTINCT a.first_name,
                a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film_category fc ON fc.film_id = fa.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name;

/* 
55. Encuentra los nombres de los actores que han actuado en películas que se alquilaron después de que ‘Spartacus Cheaper’ se alquilara por primera vez.
*/
SELECT DISTINCT a.first_name,
                a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON f.film_id = fa.film_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
    SELECT MIN(r2.rental_date)
    FROM film f2
    JOIN inventory i2 ON i2.film_id = f2.film_id
    JOIN rental r2 ON r2.inventory_id = i2.inventory_id
    WHERE f2.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name;

/* 
56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
*/
SELECT a.first_name,
       a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Music'
)
ORDER BY a.last_name;

/* 
57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
*/
SELECT DISTINCT f.title,
                (r.return_date - r.rental_date) AS dias_alquilada
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
  AND (r.return_date - r.rental_date) > INTERVAL '8 days';

/* 
58. Encuentra el título de las películas que son de la misma categoría que ‘Animation’.
*/
SELECT f.title
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.name = 'Animation'
ORDER BY f.title;

/* 
59. Encuentra las películas que tienen la misma duración que la película ‘Dancing Fever’.
*/
SELECT f2.title
FROM film f2
WHERE f2.length = (
    SELECT length
    FROM film
    WHERE title = 'Dancing Fever'
)
ORDER BY f2.title;

/* 
60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas.
*/
SELECT c.first_name,
       c.last_name,
       COUNT(DISTINCT f.film_id) AS peliculas_distintas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT f.film_id) >= 7
ORDER BY c.last_name;

/* 
61. Encuentra la cantidad total de películas alquiladas por categoría.
*/
SELECT c.name AS categoria,
       COUNT(r.rental_id) AS total_alquileres
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY c.name
ORDER BY total_alquileres DESC;

/* 
62. Encuentra el número de películas por categoría estrenadas en 2006.
*/
SELECT c.name AS categoria,
       COUNT(f.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
WHERE f.release_year = 2006
GROUP BY c.name
ORDER BY total_peliculas DESC;

/* 
63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
*/
SELECT s.staff_id,
       s.first_name,
       st.store_id
FROM staff s
CROSS JOIN store st;

/* 
64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
*/
SELECT c.customer_id,
       c.first_name,
       c.last_name,
       COUNT(r.rental_id) AS total_alquileres
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY total_alquileres DESC;

