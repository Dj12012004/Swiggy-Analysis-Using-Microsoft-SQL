select * from swiggy_data

--Data validation & cleaning
--Null check
select 
	sum(case when state is null then 1 else 0 end) as null_state,
	sum(case when city is null then 1 else 0 end) as null_city,
	sum(case when order_date is null then 1 else 0 end) as null_order_date,
	sum(case when restaurant_name is null then 1 else 0 end) as null_restaurant,
	sum(case when location is null then 1 else 0 end) as null_location,
	sum(case when category is null then 1 else 0 end) as null_category,
	sum(case when dish_name is null then 1 else 0 end) as null_dish,
	sum(case when price_inr is null then 1 else 0 end) as null_price,
	sum(case when rating is null then 1 else 0 end) as null_rating,
	sum(case when rating_count is null then 1 else 0 end) as null_rating
from swiggy_data ;

--Blank & empty strings
select *
from swiggy_data
where 
state = '' or city = '' or location = '' or category = '' or Dish_Name = '';

--Duplicate Detection
select 
state , city , order_date , restaurant_name , location , category , 
dish_name , price_inr , rating , rating_count , count(*) as CNT 
from swiggy_data
group by 
state , city , order_date , restaurant_name , location , category , 
dish_name , price_inr , rating , rating_count
having count(*) > 1

--Delete Duplication
with cte as ( 
select * , row_number() over (
partition by state , city , order_date , restaurant_name , location , category , 
dish_name , price_inr , rating , rating_count 
order by ( select null )
) as rn 
from swiggy_data
) 
delete from cte where rn > 1;
