# Swiggy-Analysis-Using-Microsoft-SQL
End-to-end SQL data warehouse project to analyze Swiggy sales data. Created a star schema (fact and dimensions), cleaned the data, and created KPIs such as revenue, order, location, pricing, and rating distribution. Provided organized business insights using T-SQL on Microsoft SQL Server.


## Project Overview
This project aims at developing a comprehensive end-to-end analytical solution using Microsoft SQL Server. The aim was to take unrefined Swiggy food delivery data and convert it into a Star Schema and then extract valuable business insights using SQL-based KPI analysis. 
The project showcases:
* 1. Data Cleaning & Validation
* 2. Dimensional Modeling (Star Schema)
* 3. Fact & Dimension Table Design
* 4. KPI Development
* 5. Business Insight Extraction


## Business Objective
To analyze food delivery performance across:
* Time (Monthly, Quarterly, Day-wise)
* Geography (City, State)
* Restaurants & Categories
* Pricing Segments
* Customer Ratings
The goal is to identify trends, high performing segments, and customer behavior patterns.


## Dataset Description
The dataset swiggy_data contains food delivery transaction level records including:
* State
* City
* Order_Date
* Restaurant_Name
* Location
* Category
* Dish_Name
* Price_INR
* Rating
* Rating_Count
Each row shows one single order made by a customer.

## 1. Data Cleaning & Validation
The Following validations were performed :
  * Null Check
    Checked all business critical columns for missing values.
  * Blank Value Detection
    Validated empty string occurrences.
  * Duplicate Detection
    Used GROUP BY + HAVING to detect duplicates.
  * Duplicate Removal
    Used row_number() over (partition by... order by (select null)) to remove duplicates

## 2. Dimensional Modeling - Star Schema 
A Star Schema is a way of organizing data for analysis where one central table (fact table) stores measurable data like orders and revenue, and it is connected to multiple smaller tables (dimension tables) that describe details like date, location, restaurant, and category. This structure makes data easy to understand, query, and analyze efficiently.

## 3. Fact & Dimension Table Design

The Star schema contains :
### Dimension Tables
* dim_date
* dim_location
* dim_restaurant
* dim_category
* dim_dish
Each dimension uses surrogate keys (int identity primary key).

### Fact Table
fact_swiggy_orders

Measures :
* Price_INR
* Rating
* Rating_Count

Foreign Keys :
* date_id
* location_id
* restaurant_id
* category_id
* dish_id

### Finally Schema validation :
I joined the fact table with all dimension tables to make sure every key matches correctly. All relationships were checked and the star schema is working properly.

##  4. KPI Development

### Core KPIs : 
* Total Orders - 197,401
* Total Revenue - ₹21 Million
* Average Dish Price - ₹268.50
* Average Rating - 4.34

### Date Based Analysis :
#### Monthly Trends :
  * Monthly Order Volume :-
     * January - 25,393
     * February - 23,291
     * March - 24,400
     * April - 24,584
     * May - 25,188
     * June - 24,382
     * July - 24,936
     * August - 25,227
   Highest: January
   Lowest: February
  * Monthly Revenue(₹) :-
     * January - 6,823,981 
     * February - 6,268,106
     * March - 6,572,738
     * April - 6,590,449
     * May - 6,792,621
     * June - 6,513,676
     * July - 6,650,268
     * August - 6,790,899

#### Quarterly Trends :
  * Quarterly Order Volume
  * Quarterly Revenue

#### Day of Week Pattern :
  * Weekend shows slightly higher demand
  

  

      
