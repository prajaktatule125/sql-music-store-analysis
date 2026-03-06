-- Q. 1  Who is the most senior employee

select top 1 * from employee
order by levels desc

-- Q.2  which country have the most invoices?

select count(*) as total_invoices,
billing_country
from invoice
group by billing_country
order by total_invoices desc

--Q. 3  What are top 3 values of total invoice

select top 3 total from invoice
order by total desc

-- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
--Write a query that returns one city that has the highest sum of invoice totals. 
--Return both the city name & sum of all invoice totals 

select billing_city , sum(total) as invoice_total
from invoice
group by billing_city
order by invoice_total desc

--Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
--Write a query that returns the person who has spent the most money.

select top 1 customer.customer_id,customer.first_name,customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id, customer.first_name, customer.last_name
order by total desc

--Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
--Return your list ordered alphabetically by email starting with A.

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Genre
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

--Q7: Let's invite the artists who have written the most rock music in our dataset. 
--Write a query that returns the Artist name and total track count of the top 10 rock bands.

select top 10
artist.artist_id,
artist.name ,
count(artist.artist_id) as no_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id , artist.name
order by no_of_songs desc

--Q8: Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.

select track.name,
track.milliseconds
from track 
where milliseconds >(select avg(milliseconds) from track)
order by milliseconds desc


-- Q9: Find how much amount spent by each customer on artists? Write a query to return customer name, 
--artist name and total spent 


SELECT 
    c.first_name,
    c.last_name,
    ar.name AS artist_name,
    SUM(il.unit_price * il.quantity) AS total_spent
FROM customer c
JOIN invoice i ON i.customer_id = c.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album al ON al.album_id = t.album_id
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY c.first_name, c.last_name, ar.name
ORDER BY total_spent DESC;


/* Q10: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.
First find the most spent on music for each country and second filter the data for respective customers.
*/

WITH Customter_with_country AS (
    SELECT 
        customer.customer_id,
        first_name,
        last_name,
        billing_country,
        SUM(total) AS total_spending,
        ROW_NUMBER() OVER(
            PARTITION BY billing_country 
            ORDER BY SUM(total) DESC
        ) AS RowNo
    FROM invoice
    JOIN customer 
        ON customer.customer_id = invoice.customer_id
    GROUP BY customer.customer_id, first_name, last_name, billing_country
)

SELECT * FROM Customter_with_country WHERE RowNo <= 1;










