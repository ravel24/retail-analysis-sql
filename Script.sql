-- Cari produk dengan msrp paling tinggi 
SELECT *, msrp 
from products p 
order by msrp DESC 
limit 1

--Cari sales_rep_employee_number dengan banyak customer > 3.
SELECT e.employee_number , concat(first_name,' ',last_name) , COUNT(*) as total_Customer
from employees e left join customers c on e.employee_number = c.sales_rep_employee_number   
group by e.employee_number 
having count(*) > 3  --3

--Kota yang memiliki banyak order tertinggi
SELECT c.city, count(DISTINCT o.customer_number) as total_order from 
orders o left join customers c ON o.customer_number = c.customer_number  
GROUP BY city 
ORDER BY total_order DESC --4

---------------------------BASKETSIZE-------------------------------
--------cari transaksi perkota, produk_unik perkota, Quantity produk perkota------
----------WITH CTE 
WITH CTE_Total_Transactions AS (
    SELECT 
        c.city, 
        COUNT(*) AS total_transaksi
    FROM 
        customers c 
    INNER JOIN payments p ON c.customer_number = p.customer_number 
    GROUP BY 
        c.city
),
CTE_Average_Basket_Size AS (
    SELECT
        c.city,
        SUM(od.quantity_ordered) AS total_quantity,
        COUNT(DISTINCT od.product_code) AS total_uniq_product,
        SUM(od.quantity_ordered) / COUNT(o.order_number) AS average_basket_size
    FROM
        orders o
    INNER JOIN customers c ON o.customer_number = c.customer_number
    INNER JOIN orderdetails od ON o.order_number = od.order_number
    GROUP BY
        c.city
)
SELECT 
    t.city,
    t.total_transaksi,
    a.total_uniq_product,
    a.total_quantity,
    a.average_basket_size
FROM 
    CTE_Total_Transactions t
LEFT JOIN 
    CTE_Average_Basket_Size a ON t.city = a.city









