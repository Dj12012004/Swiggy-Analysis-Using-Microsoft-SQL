--KPIs
--Core KPIs

-- Q1 Total Orders
select count(*) as Total_Orders
from fact_swiggy_orders

-- Q2 Total Revenue(INR Million)
select 
format(sum(convert(float,price_inr))/1000000,'N2') + 'INR Million'
as Total_Revenue
from fact_swiggy_orders

-- Q3 Average Dish Price
select
format(avg(convert(float,price_inr)), 'N2') + 'INR'
as Average_Price_Per_Dish
from fact_swiggy_orders

-- Q4 Average Rating
select
format(avg(rating), 'N2')
as Average_Rating_Per_Order
from fact_swiggy_orders

-- Date Based Analysis
-- Q5 Monthly Orders
select
d.year ,
d.month , 
d.month_name,
count(*) as Total_Orders
from fact_swiggy_orders f
join dim_date d on f.date_id = d.date_id
group by d.year ,
d.month , 
d.month_name 
order by Total_Orders desc;
-- Q6 Monthly Revenue 
select
d.year , 
d.month ,
d.month_name,
sum(price_inr) as Total_Revenue
from fact_swiggy_orders f
join dim_date d on f.date_id = d.date_id 
group by
d.year , 
d.month ,
d.month_name
order by sum(price_inr) desc 

-- Q7 Quarterly Order Trends
select 
d.year , 
d.quarter , 
count(*) as Total_Orders
from fact_swiggy_orders f
join dim_date d on f.date_id = d.date_id
group by
d.year , 
d.quarter 
order by count(*) desc

select 
d.year , 
d.quarter ,
sum(Price_INR) as Total_Revenue
from fact_swiggy_orders f
join dim_date d on f.date_id = d.date_id
group by 
d.year , 
d.quarter
order  by sum(Price_INR) desc

-- Q8 Day of the Week Orders Pattern
select 
datename(weekday,d.full_date) as Day_Name ,
count(*) as Total_Orders
from fact_swiggy_orders f
join dim_date d on f.date_id = d.date_id
group by 
datename(weekday,d.full_date), 
datepart(weekday,d.full_date)
order by datepart(weekday,d.full_date) 

--Location Based Analysis
-- Q9 Top 10 Cities By Order Volume
select top 10
l.city,
count(*) as Total_Orders 
from fact_swiggy_orders f
join dim_location l 
on f.location_id = l.location_id
group by 
l.city
order by count(*) desc

-- Q10 Revenue Contribution By States
 select 
 l.state , 
 sum(f.price_inr) as Total_Revenue
 from fact_swiggy_orders f
 join dim_location l 
 on f.location_id = l.location_id
 group by 
 l.state
 order by sum(price_INR) desc
 
 --Food Performance 
 -- Q11 Top 10 Restaurant by Order
 select top 10
 r.restaurant_name ,
 count(f.order_id) as Total_Orders
 from fact_swiggy_orders f
 join dim_restaurant r on f.restaurant_id = r.restaurant_id
 group by 
 r.restaurant_name
 order by count(f.order_id) desc

 -- Q12 Top Categories(Indian,Chinese,etc)
 select 
 c.category ,
 count(f.category_id) as Top_Categories
 from fact_swiggy_orders f
 join dim_category c
 on f.category_id = c.category_id
 group by 
 c.category
 order by count(f.category_id) desc
 offset 1 row
 fetch next 10 rows only
 
 -- Q13 Most Ordered Dishes
 select Top 10
 d.dish_name , 
 count(f.dish_id) as Order_Count
 from fact_swiggy_orders f
 join dim_dish d 
 on f.dish_id = d.dish_id
 group by 
 d.Dish_Name
 order by count(f.dish_id) desc
 
 -- Q14 Cuisine Performance(Orders + Average Rating)
select 
c.category,
count(f.order_id) as Total_Orders,
avg(f.rating) as Average_Rating 
from fact_swiggy_orders f
join dim_category c
on f.category_id = c.category_id
group by 
c.category
order by Total_Orders desc
offset 1 row
fetch next 10 rows only

--Customer Spending Insights
-- Q15 Total Orders By Price Range
select 
	case 
		when convert(float,price_inr) < 100 then 'Under 100'
		when convert(float,price_inr) between 100 and 199 then '100-199'
		when convert(float,price_inr) between 200 and 299 then '200-299'
		when convert(float,price_inr) between 300 and 499 then '300-499'
		else '500+'
	end as Price_Range,
	count(*) as Total_Orders
from fact_swiggy_orders
group by
	case 
		when convert(float,price_inr) < 100 then 'Under 100'
		when convert(float,price_inr) between 100 and 199 then '100-199'
		when convert(float,price_inr) between 200 and 299 then '200-299'
		when convert(float,price_inr) between 300 and 499 then '300-499'
		else '500+'
	end 
order by Total_Orders desc

-- Q16 Rating Count Distribution (1-5)
select
rating ,
count(*) as Rating_Count
from fact_swiggy_orders
group by rating
order by Rating_Count
		
