create database amazon;
use amazon;
create table amazondata(Invoice_id VARCHAR(30),Branch VARCHAR(5),City VARCHAR(30),Customer_type VARCHAR(30),Gender VARCHAR(10),Product_line VARCHAR(100),Unit_price DECIMAL(10, 2),
Quantity INT,Tax DECIMAL(10, 4),Total DECIMAL(10, 4),Date1 Date,Time1 Time,Payment_method VARCHAR(30),cogs DECIMAL(10, 4),gross_margin_percentage FLOAT,gross_income DECIMAL(10, 2),
Rating FLOAT);
select * from amazondata;
ALTER TABLE amazondata
ADD COLUMN TimeofDay VARCHAR(30);
select * from amazondata;
ALTER TABLE amazondata
ADD COLUMN DayName1 VARCHAR(30);
ALTER TABLE amazondata
ADD COLUMN MonthName1 VARCHAR(30);
ALTER TABLE amazondata
drop COLUMN MonthName;
select * from amazondata;
update amazondata set TimeofDay ='Morining' where time1 between '00:00:00' and '12:00:00';
update amazondata set TimeofDay ='Afternoon' where time1 between '12:00:00' and '16:00:00';
update amazondata set TimeofDay ='Evening' where time1 between '16:00:00' and '24:00:00';
 
update amazondata set MonthName1 = MONTHNAME(Date1);
update amazondata set DayName1 = DayNAME(Date1);
-- Que 1 What is the count of distinct cities in the dataset?

select * from amazondata;
select city,count(city) from amazondata group by city;

-- Que 2 For each branch, what is the corresponding city?

select * from amazondata;
select distinct branch,city from amazondata;

-- Que 3 What is the count of distinct product lines in the dataset?

select * from amazondata;
select product_line,count(product_line) from amazondata group by product_line

-- Que 4 Which payment method occurs most frequently?

select * from amazondata;
select Payment_method,count(payment_method) as Most_frequent_method from amazondata group by payment_method limit 1;

-- Que 5 Which product line has the highest sales?
select * from amazondata;
select Product_line,sum(quantity) as Highest_sale from amazondata group by product_line limit 1; 

-- Que 6 How much revenue is generated each month?
select * from amazondata;
select monthname1,sum(total) as Revenue_Generated from amazondata group by monthname1;

-- Que 7 In which month did the cost of goods sold reach its peak?

select * from amazondata;
select monthname1,sum(cogs) from amazondata group by monthname1 limit 1;

-- Que 8 Which product line generated the highest revenue?

select * from amazondata;
select product_line,sum(gross_income) as Highest_Revenue from amazondata group by product_line order by sum(gross_income) desc;

-- Que 9 In which city was the highest revenue recorded?

select * from amazondata;
	select city,sum(gross_income) as Highest_Revenue from amazondata group by city order by sum(gross_income) desc;

-- Que 10 Which product line incurred the highest Value Added Tax?

select * from amazondata;
select product_line,sum(Tax) as Highest_VAT from amazondata group by product_line order by sum(Tax) desc;

-- Que 11 For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
select * from amazondata;
select Product_line,total,
   case
   when total>(select avg(total) from amazondata) then "Good"
   else "Bad"
end as "Rating"
from amazondata group by Product_line,total;

-- Que 12 Identify the branch that exceeded the average number of products sold.

select * from amazondata;
select invoice_id,branch,quantity from amazondata where quantity>(select avg(quantity) from amazondata);

-- Que 13 Which product line is most frequently associated with each gender?

select * from amazondata;
select product_line,gender,count(product_line) from amazondata group by gender,product_line order by count(product_line) desc;

-- Que 14 Calculate the average rating for each product line.

select * from amazondata;
select product_line,avg(rating) from amazondata group by product_line;

-- Que 15 Count the sales occurrences for each time of day on every weekday.

select * from amazondata;
select dayname1,timeofday,count(invoice_id) from amazondata where dayname1 not in ('Saturday','Sunday')
group by dayname1,timeofday order by count(invoice_id) desc;

-- Que 16 Identify the customer type contributing the highest revenue.

select * from amazondata;
select customer_type,sum(gross_income) from amazondata group by customer_type;

-- Que 17 Determine the city with the highest VAT percentage.

select * from amazondata;
select city,sum(tax) from amazondata group by city order by sum(tax) desc;

-- Que 18 Identify the customer type with the highest VAT payments.

select * from amazondata;
select customer_type,sum(tax) from amazondata group by customer_type order by sum(tax) desc;

-- Que 19 What is the count of distinct customer types in the dataset?

select * from amazondata;
select  customer_type,count(customer_type) from amazondata group by customer_type;

-- Que 20 What is the count of distinct payment methods in the dataset?

select * from amazondata;
select payment_method,count(payment_method) from amazondata group by payment_method;

-- Que 21 Which customer type occurs most frequently?

select * from amazondata;
select customer_type,count(customer_type) from amazondata group by customer_type order by count(customer_type) desc;
 
-- Que 22 Identify the customer type with the highest purchase frequency.

select * from amazondata;
select customer_type,count(Invoice_id) from amazondata group by customer_type;

-- Que 23 Determine the predominant gender among customers.

select * from amazondata;
select gender,count(gender) from amazondata group by gender;

 -- Que 24 Examine the distribution of genders within each branch.

select * from amazondata;
select gender,count(gender) from amazondata  where branch = 'A' group by gender;
select gender,count(gender) from amazondata  where branch = 'B' group by gender;
select gender,count(gender) from amazondata  where branch = 'c' group by gender;

-- Que 25 Identify the time of day when customers provide the most ratings.

select * from amazondata;
select timeofday,count(rating) from amazondata group by timeofday order by count(rating) desc;

-- Que 26 Determine the time of day with the highest customer ratings for each branch.

select * from amazondata;
select timeofday,branch,count(rating) from amazondata group by timeofday,branch order by count(rating) desc;


-- Que 27 Identify the day of the week with the highest average ratings.

select * from amazondata;
select dayname1,avg(rating) from amazondata group by dayname1 order by avg(rating) desc;

-- Que 28 Determine the day of the week with the highest average ratings for each branch.

select * from amazondata;
select dayname1,branch,avg(rating) from amazondata group by dayname1,branch order by avg(rating) desc;