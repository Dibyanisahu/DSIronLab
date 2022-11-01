use sakila;

#1 Which actor has appeared in the most films?
SELECT count(film_actor.actor_id), actor.first_name, actor.last_name 
FROM actor INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY film_actor.actor_id 
order by count(film_actor.actor_id) DESC 
LIMIT 1;

#2 Most active customer (the customer that has rented the most number of films)
SELECT  cust.first_name, cust.last_name,count(*) as Total_Rentals
FROM rental as r
INNER JOIN customer AS cust on r.customer_id = cust.customer_id
GROUP BY cust.customer_id, cust.first_name
ORDER BY Total_Rentals DESC LIMIT 1;

#3 List number of films per category
SELECT  cat.name,count(cat.name) as Film_count
From category as cat
Inner join film_category as fcat on cat.category_id = fcat.category_id
Group by cat.name
order by Film_count Desc;

#4 Display the first and last names, as well as the address, of each staff member.
SELECT  s.first_name, s.last_name, ad.address
From staff as s
Inner join address as ad on s.address_id = ad.address_id;

#5 get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.
SELECT  f.title, l.name
From language as l
Inner join film as f on l.language_id = f.language_id
WHERE f.title LIKE 'M%' and  (l.name = 'English' or l.name = 'Italian');

#6 Display the total amount rung up by each staff member in August of 2005.
SELECT  s.first_name, s.last_name, sum(p.amount)
From staff as s
Inner join payment as p on s.staff_id = p.staff_id
where p.payment_date between "2005-08-01 00:00:00" and "2005-08-30 23:59:59" 
Group by s.staff_id
order by sum(p.amount);

#7 
SELECT  f.title,count(fa.actor_id) as actor_count
From film_actor as fa
Inner join film as f using (film_id)
Group by f.title;

#8 Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT  cust.first_name, cust.last_name, sum(p.amount)
From customer as cust
Inner join payment as p using (customer_id)
group by p.customer_id
order by cust.last_name ;

#9 Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT  a.first_name, a.last_name, count(fa.film_id)
From actor as a
Inner join film_actor as fa using (actor_id)
group by a.actor_id having count(fa.film_id)=0;

#10 get the addresses that has NO customers, and ends with the letter "e"
SELECT  ad.address,ad.address2
From address as ad
left join customer as cust using(address_id)
WHERE ad.address LIKE '%e' and cust.customer_id is null;

#OPTIONAL----------
#11 what is the most rented film?
SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i using (film_id)
JOIN rental r using (inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC
limit 2;
