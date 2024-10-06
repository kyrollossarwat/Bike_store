-- Display data from production schema
SELECT * FROM production.categories;
SELECT * FROM production.brands;
SELECT * FROM production.products;
SELECT * FROM production.stocks;

-- Display data from sales schema
SELECT * FROM sales.customers;
SELECT * FROM sales.stores;
SELECT * FROM sales.staffs;
SELECT * FROM sales.orders;
SELECT * FROM sales.order_items;

--1
select top 1 product_name, list_price
FROM production.products
order by list_price desc

--2
SELECT * FROM sales.customers;

select count(distinct customer_id)
from sales.customers

SELECT * FROM sales.orders;

select count(distinct customer_id)
from sales.orders
where order_status !=3

--3
SELECT * FROM sales.stores;

select count(distinct store_name)'#stores'
from sales.stores

--4
SELECT * FROM sales.order_items;

select order_id ,sum(list_price*quantity*(1-discount))as total_price_spent
from sales.order_items
group by order_id
order by total_price_spent

--5
SELECT * FROM sales.order_items;
SELECT * FROM sales.stores;


select store_name, sum(list_price*quantity*(1-discount))as sales_per_store
from sales.order_items soi join sales.orders so
on soi.order_id=so.order_id
join sales.stores ss 
on so.store_id=ss.store_id
group by store_name
order by sales_per_store


--6
SELECT * FROM production.categories;
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

select top 1 category_name , sum(quantity) as quantity_sold
from production.products pp join sales.order_items soi 
on pp.product_id=soi.product_id
join production.categories pc
on pp.category_id=pc.category_id
group by category_name
order by quantity_sold desc

--7
SELECT * FROM sales.orders;
SELECT * FROM production.categories;
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

select category_name ,count(order_status) as rejected_orders
from sales.orders so 
join sales.order_items soi on so.order_id=soi.order_id
join production.products pp on soi.product_id=pp.product_id
join production.categories pc on pp.category_id=pc.category_id
where order_status=3
group by category_name
order by rejected_orders desc

--8
SELECT * FROM production.products;
SELECT * FROM sales.order_items;

select product_name,sum(quantity)as #sold
from production.products pp
join sales.order_items soi on pp.product_id=soi.product_id
group by product_name
order by #sold 

--9
SELECT * FROM sales.customers;
select concat(first_name,' ',last_name)as full_name
from sales.customers 
where customer_id=259

--10
SELECT * FROM sales.orders
select product_name,customer_id,order_date,order_status
from sales.orders so
JOIN sales.order_items soi ON so.order_id = soi.order_id
JOIN production.products pp ON soi.product_id = pp.product_id
WHERE customer_id = 259;

--11
SELECT * FROM sales.staffs;
SELECT * FROM sales.orders;
SELECT * FROM sales.stores;
use bstore2
select concat(ss.first_name,' ',ss.last_name) as full_name  , sss.store_name
from sales.orders so
join sales.staffs ss
on so.staff_id = ss.staff_id
join sales.stores sss
on sss.store_id=ss.store_id
where so.customer_id = 259


--12
select count(staff_id)'#staff'
from sales.staffs
--
select top 1 CONCAT (ss.first_name,' ',ss.last_name) as full_name , count(order_id) as #orders
from sales.staffs ss
join sales.orders so on ss.staff_id=so.staff_id
group by ss.first_name, ss.last_name
order by #orders desc

--13
SELECT * FROM production.brands
SELECT * FROM production.products

select brand_name , count(order_id) as #orders ,SUM(soi.quantity) AS total_sold
from production.brands pb
join production.products pp on pb.brand_id=pp.brand_id
join sales.order_items soi on soi.product_id=pp.product_id
group by brand_name
order by #orders desc

--14
select category_name
from production.categories

select category_name,sum(soi.quantity)as #quantity_sold
from production.products pp
join sales.order_items soi on soi.product_id= pp.product_id
join production.categories pc on pp.category_id=pc.category_id
group by category_name
order by #quantity_sold desc

--15
select s.store_name , sum(pst.quantity) as quantity
from production.stocks pst
join production.products pp on pst.product_id=pp.product_id
join sales.stores s on pst.store_id = s.store_id
group by s.store_name
order by quantity desc

--16
select ss.state , sum (soi.list_price * soi.quantity * (1 - soi.discount)) AS total_sales
from sales.order_items soi
join sales.orders so on soi.order_id=so.order_id
join sales.stores ss on so.store_id=ss.store_id
group by ss.state
order by total_sales desc

--17
select discount
from sales.order_items
where product_id=259


--18
select distinct pp.product_name , ps.quantity,pp.list_price,pc.category_name,pp.model_year , pb.brand_name
from production.products pp
join production.brands pb on pp.brand_id=pb.brand_id
join production.categories pc on pp.category_id=pc.category_id
join production.stocks ps on ps.product_id = pp.product_id
where pp.product_id=44

--19
select distinct zip_code ,state
from sales.stores
where state='CA'

--20
select count(distinct state)'states'
from sales.stores


--21
select sum(soi.quantity)as total_sold
from sales.order_items soi
join production.products pp on soi.product_id=pp.product_id
join production.categories pc on pp.category_id=pc.category_id
join sales.orders so on so.order_id=soi.order_id
where pc.category_name='Children'
and so.order_date >= DATEADD(MONTH, -8, GETDATE())



--22
select shipped_date , customer_id ,product_name
from sales.orders so
join sales.order_items soi on so.order_id=soi.order_id
join production.products pp on soi.product_id=pp.product_id
where customer_id=523

--23
SELECT COUNT(*)  'pending_orders'
FROM sales.orders
WHERE order_status = 1


--24
SELECT p.product_name, c.category_name, b.brand_name
FROM production.products p
JOIN production.categories c ON p.category_id = c.category_id
JOIN production.brands b ON p.brand_id = b.brand_id
WHERE p.product_name = 'Electra White Water 3i - 2018'


---------------T H A N K  Y O U-----------------