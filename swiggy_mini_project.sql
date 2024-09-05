use online_food;
show tables;

describe swiggy;
select * from swiggy;

-- 

/* add primary key*/
alter table swiggy add primary key(id);

/*total no or restrts*/
select count(distinct(restaurant)) from swiggy;

/* find restaurant which apperaed more thn once*/
select count(restaurant)- count(distinct(restaurant)) as repeated_resto
from swiggy;

#or using group by 
select restaurant ,count(restaurant)
from swiggy 
group by restaurant
having count(restaurant)>1;


/* find total cities in the table*/
select count(distinct(city)) from swiggy;

/*sort no of restaurants  from each cityin descendingorder*/
select city,count(distinct(restaurant))as total_resto
from swiggy
group by city
order by total_resto desc;

/*find total orders made from each resataurant from banglr*/
select restaurant ,count(id) as orders 
from swiggy
where city='bangalore'
group by restaurant 
order by count(ID)desc;

/*find the restrnt name with maximum orders*/

select restaurant,count(id),city
from swiggy
group by restaurant,city
order by count(id) desc
limit 1;

/* find restaurant names with max orde*/
select restaurant ,city,total_orders
from(select restaurant,city,count(id) as total_orders,
dense_rank()over(order by count(id)desc) as rankk
from swiggy
group by restaurant,city) as rankings
where rankk =1;


#less useful way
select restaurant ,city,count(id) as total_orders
from swiggy 
group by restaurant ,city
order by count(id) desc 
limit 1;

/* find top 3 resto names with maximum orders*/
select restaurant, city,total_orders,ranking
from(select restaurant ,city,count(id) as total_orders,
dense_rank () over (order by count(id) desc) as ranking
from swiggy 
group by restaurant,city) as table_ranked
where ranking between 1 and 3;

/* find restaurants from kormangala area of bangalore who serve chinese food*/
select restaurant 
from swiggy
where city ='Bangalore' and area ='Kormangala' and
Food_type like 'Chinese';

/* find average time taken by swiggy*/
select avg(Delivery_time) from swiggy;

 /* find average delivery time taken by swiggy in each city */
 select city,avg(Delivery_time) as average_delivery_time from swiggy
 group by city
 order by average_delivery_time; 

/*find all restaurants from mumbai,delhi,and kolkata who serve north indian and south indian dishes*/
select * from swiggy
where city in ('Mumbai','Delhi','Kolkata') and 
food_type like '%North Indian%' and food_type like'%South Indian%';
