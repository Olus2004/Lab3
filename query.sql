-- 1.  Số lượng top 10 gian hàng bán chạy
SELECT 
    s.idstore,
    s.storeName,
    SUM(oi.quantity * oi.price) AS total_revenue,
    SUM(oi.quantity) AS total_quantity_sold
FROM 
    store s
    JOIN category c ON s.idstore = c.idstore
    JOIN product p ON c.idcategory = p.idcategory
    JOIN oderitem oi ON p.idproduct = oi.idproduct
    JOIN orders o ON oi.idorders = o.idorders
WHERE 
    o.statusOder = 2 -- Chỉ tính các đơn hàng đã hoàn thành
GROUP BY 
    s.idstore, s.storeName
ORDER BY 
    total_revenue DESC
LIMIT 10;

-- 2. Top 10 sản phẩm bán chạy nhất
SELECT 
    p.idproduct,
    p.productName,
    p.productCode,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM 
    product p
    JOIN oderitem oi ON p.idproduct = oi.idproduct
    JOIN orders o ON oi.idorders = o.idorders
WHERE 
    o.statusOder = 2 -- Chỉ tính các đơn hàng đã hoàn thành
GROUP BY 
    p.idproduct, p.productName, p.productCode
ORDER BY 
    total_quantity_sold DESC, total_revenue DESC
LIMIT 10;

-- 3. Top 10 khách hàng mua nhiều nhất
SELECT 
    u.iduser,
    u.username,
    COUNT(o.idorders) AS total_orders,
    SUM(o.totalPrice) AS total_spent
FROM 
    user u
    JOIN orders o ON u.iduser = o.customerId
WHERE 
    u.idrole = 3 -- Chỉ tính khách hàng (customer)
    AND o.statusOder = 2 -- Chỉ tính các đơn hàng đã hoàn thành
GROUP BY 
    u.iduser, u.username
ORDER BY 
    total_spent DESC
LIMIT 10;
