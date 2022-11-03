#1 Write a query to display for each store its store ID, city, and country.
use sakila;
select s.store_id,c.city,cou.country 
from store as s left join address as a using(address_id)
join city as c using(city_id)
join country as cou using (country_id)

#2 Write a query to display how much business, in dollars, each store brought in.
select c.store_id,sum(a.amount)
from payment as a
left join staff as b using (staff_id)
left join store as c using (store_id)
group by 1;

#3 What is the average running time(length) of films by category?
use sakila;
Select c.name, avg(f.length) as avg_run_time
from film as f
join film_category as fc using (film_id)
join category as c using (category_id)
group by c.category_id;

#4 Which film categories are longest(length) (find Top 5)? (Hint: You can rely on question 3 output.)
Select c.name, avg(f.length) as avg_run_time
from film as f
join film_category as fc using (film_id)
join category as c using (category_id)
group by c.category_id 
having avg(f.length) > (select avg(length) from film)
order by avg(length) desc;

#5 Display the top 5 most frequently(number of times) rented movies in descending order.
SELECT f.title, COUNT(f.title) as rentals from film f 
JOIN 
	(SELECT r.rental_id, i.film_id FROM rental r 
    JOIN 
    inventory i ON i.inventory_id = r.inventory_id) a
    ON a.film_id = f.film_id GROUP BY f.title ORDER BY rentals DESC;

#6 List the top five genres in gross revenue in descending order.
SELECT cat.name as category, SUM(d.revenue) as revenue from category cat 
JOIN
    (SELECT catf.category_id, c.revenue FROM film_category catf 
	JOIN 
		(SELECT i.film_id, b.revenue FROM inventory i 
		JOIN 
			(SELECT r.inventory_id, a.revenue from rental r 
			JOIN 
				(SELECT p.rental_id, p.amount as revenue FROM payment p) a 
				ON a.rental_id = r.rental_id) b
			ON b.inventory_id = i.inventory_id) c
		ON c.film_id = catf.film_id) d 
	ON d.category_id = cat.category_id GROUP BY cat.name
  ORDER BY revenue DESC
  LIMIT 5;   

#7 Is "Academy Dinosaur" available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from inventory join store using (store_id) join film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;

