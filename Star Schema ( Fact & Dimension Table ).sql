--Creating Schema 
--Dimension Tables
--Date Table
create table dim_date(
	date_id int identity(1,1) primary key,
	Full_Date date,
	year int,
	month int,
	Month_Name varchar(25),
	quarter int,
	day int,
	week int
	)

--Location Table
create table dim_location(
	location_id int identity(1,1) primary key,
	state varchar(100),
	city varchar(100),
	location varchar(100)
	);

--Restaurant Table 
create table dim_restaurant(
restaurant_id int identity(1,1) primary key,
restaurant_name varchar(200)
);

--Category Table
create table dim_category(
category_id int identity(1,1) primary key,
category varchar(200)
);

--Dish Table
create table dim_dish(
dish_id int identity(1,1) primary key,
Dish_Name varchar(200)
);


--Fact Table 
create table fact_swiggy_orders(
	order_id int identity(1,1) primary key,
	Price_INR decimal(10,2),
	Rating decimal(4,2),
	Rating_Count int ,

	date_id int,
	location_id int,
	restaurant_id int,
	category_id int,
	dish_id int,

	foreign key (date_id) references dim_date(date_id),
	foreign key (location_id) references dim_location(location_id),
	foreign key (restaurant_id) references dim_restaurant(restaurant_id),
	foreign key (category_id) references dim_category(category_id),
	foreign key (dish_id) references dim_dish(dish_id)
);


--Insert Data Into Tables
--Date Table
insert into dim_date(Full_Date , year , month , Month_Name , quarter , day , week)
select distinct
	order_date,
	year(order_date),
	month(order_date),
	datename(month, order_date),
	datepart(quarter,order_date),
	day(order_date),
	datepart(week,order_date)
from swiggy_data
where order_date is not null;

--Location Table
insert into dim_location(state , city , location)
select distinct	
	state ,
	city , 
	location 
from swiggy_data;

--Restaurant Table
insert into dim_restaurant (restaurant_name)
select distinct
	Restaurant_Name 
from swiggy_data ;

--Category Table
insert into dim_category (category)
select distinct
	category
from swiggy_data;

--Dish Table
insert into dim_dish(Dish_Name)
select distinct	
	Dish_Name
from swiggy_data;

--Fact Table
insert into fact_swiggy_orders
(
	Price_INR , 
	Rating , 
	Rating_Count , 
	date_id , 
	location_id , 
	restaurant_id , 
	category_id , 
	dish_id		
)
select 
	s.Price_INR ,
	s.Rating , 
	s.Rating_Count ,
	dd.date_id , 
	dl.location_id ,
	dr.restaurant_id , 
	dc.category_id , 
	dsh.dish_id
from swiggy_data s

join dim_date dd
	on dd.Full_Date = s.Order_Date

join dim_location dl
	on dl.state = s.State
	and dl.city = s.City
	and dl.location = s.Location

join dim_restaurant dr
	on dr.restaurant_name = s.Restaurant_Name

join dim_category dc
	on dc.category = s.Category

join dim_dish dsh
	on dsh.Dish_Name = s.Dish_Name

--Final Fact Table With All Dimensions
select * from fact_swiggy_orders f
join dim_date d on f.date_id = d.date_id 
join dim_location l on f.location_id = l.location_id
join dim_restaurant r on f.restaurant_id = r.restaurant_id
join dim_category c on f.category_id = c.category_id
join dim_dish di on f.dish_id = di.dish_id
