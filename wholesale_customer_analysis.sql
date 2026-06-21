
SELECT* FROM wholesale_customers_data;
-- Find the top 5 customers with the highest total spending across all categories--
select *, 
	(fresh + milk + grocery + frozen + detergents_paper + delicassen) as total_spending
from wholesale_customers_data
	order by total_spending desc
	limit 5;

-- Calculate the average spending in each category for every region and determine which region spends the most on average
select region,
	AVG(fresh) as avg_fresh,
    AVG(milk) as avg_milk,
    AVG(grocery) as avg_grocery,
    AVG(frozen) as avg_frozen,
    AVG(detergents_paper) as avg_detergents_paper,
    AVG(delicassen) as avg_delicassen
FROM wholesale_customers_data
GROUP BY region
ORDER BY region;
select region,
	AVG(fresh + milk + grocery + frozen + detergents_paper + delicassen) as avg_total_spending
FROM wholesale_customers_data
GROUP BY region
ORDER BY avg_total_spending desc;

-- choose whose fresh spending is above average
select fresh
from wholesale_customers_data
	where fresh>
		(select avg(fresh) as avg_fresh
from wholesale_customers_data);

-- count numbers of customers in each channel
select channel,
	count(*) as customer_count
from wholesale_customers_data
	group by channel
	order by customer_count desc;

-- find customers who spends more on grocery than on fresh and milk combined
select *
from wholesale_customers_data
	where grocery > (fresh + milk);
    
-- rank customers within each region by total spending
select region,
		(fresh + milk + grocery + frozen + detergents_paper + delicassen) as total_spending,
rank() over (
		partition by region
        order by (fresh + milk + grocery + frozen + detergents_paper + delicassen) desc
        ) as spending_rank
from wholesale_customers_data;
