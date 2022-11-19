use sakila;
-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over(order by length) as 'Rank' from film where length != 0 or length != " ";
-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
select title, rating, length, rank() over(partition by rating order by length) as 'Rank' from film where length != 0 or length != " ";
-- How many films are there for each of the categories in the category table?
select name, count(film_id) as Cat_count from category inner join film_category on category.category_id = film_category.category_id group by category.name;
-- Which actor has appeared in the most films?
select actor.last_name, actor.actor_id, count(film_id) as movie_count from actor inner join film_actor on actor.actor_id = film_actor.actor_id group by actor.last_name;
-- Which is the most active customer (the customer that has rented the most number of films)? 
select c.first_name, c.last_name, c.customer_id, count(rental_id) as number_of_rental from customer as c inner join rental on rental.customer_id = c.customer_id group by c.first_name, c.last_name;
-- Which is the most rented film
select f.film_id, f.title, count(rental_id) as number_of_rental from film as f inner join inventory as i on f.film_id = i.film_id
inner join rental on i.inventory_id = rental.inventory_id
group by f.title, f.film_id 
order by number_of_rental desc;