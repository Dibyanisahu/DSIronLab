#1 List all films whose length is longer than the average of all the films.

use sakila;
select title
from film where length > (select avg(length) from film)
order by title asc;

#2 How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, COUNT(inventory_id)
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

# 3 Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name, last_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
        
#4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT title, category
FROM film_list
WHERE category = 'Family';

#5 Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select c.first_name,c.last_name,c.email,cou.country
from customer as c join address as a using (address_id)
join city as cit using (city_id)
join country as cou using(country_id)
having cou.country = "canada"		

#OPTIONAL--------
#6 Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.       

select title from film
where film_id in
(select film_id from film_actor where actor_id = (select actor_id from film_actor
group by actor_id
order by count(*) desc
limit 1));

#7 Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select title from film
where film_id in 
(select film_id from inventory where inventory_id in
(select inventory_id from rental where customer_id = (select customer_id from payment
group by customer_id
order by sum(amount) desc
limit 1)
));

#8 Customers who spent more than the average payments(this refers to the average of all amount spent per each customer).

with hp as (select customer_id, sum(amount) as avg_amt from payment
group by customer_id
order by avg(amount) desc)
select distinct(hp.customer_id), c.first_name,c.last_name,hp.avg_amt from hp
join (customer as c) using (customer_id)
join payment as p using (customer_id)
where hp.avg_amt > (select avg(hp.avg_amt) from hp)
order by c.first_name;