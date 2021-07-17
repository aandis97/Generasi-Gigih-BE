create table customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) UNIQUE 
);


create table orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id int,
    date datetime NOT NULL,
    total decimal(15,2) not null,
    FOREIGN KEY (customer_id)
        REFERENCES customers(id)
);


create table order_details(
    order_id int,
    item_id int,
    quantity int,
    FOREIGN KEY (order_id)
        REFERENCES orders(id),
        CONSTRAINT order_detail_fk_item_id
    FOREIGN KEY (item_id)
        REFERENCES items(id)
);

insert into customers (name, phone) values ('Hangga yudo','085312321');
insert into customers (name, phone) values ('John Doe','085312399');
insert into customers (name, phone) values ('Rose Bush','085319672');
insert into customers (name, phone) values ('Peter Knee','085312862');
insert into customers (name, phone) values ('Supardi Nasir','085312531');  

insert into orders (customer_id, date, total) values (1, now(), 9999);
insert into orders (customer_id, date, total) values (3, now(), 9999);
insert into orders (customer_id, date, total) values (4, now(), 9999);
insert into orders (customer_id, date, total) values (5, now(), 9999);
insert into orders (customer_id, date, total) values (6, now(), 9999);


insert into order_details (order_id, item_id, quantity) values (1, 1, 2);
insert into order_details (order_id, item_id, quantity) values (1, 2, 2);
insert into order_details (order_id, item_id, quantity) values (3, 4, 2);
insert into order_details (order_id, item_id, quantity) values (3, 1, 2);
insert into order_details (order_id, item_id, quantity) values (3, 8, 2);
insert into order_details (order_id, item_id, quantity) values (4, 3, 1);
insert into order_details (order_id, item_id, quantity) values (5, 2, 1);
insert into order_details (order_id, item_id, quantity) values (5, 6, 1);
insert into order_details (order_id, item_id, quantity) values (2, 7, 1);


select  
orders.id, orders.date, orders.total, orders.customer_id, customers.name, customers.phone 
from orders
join customers on customers.id = orders.customer_id;


select  
orders.id, orders.date, orders.total, orders.customer_id, customers.name, customers.phone , items.name as item_name,
items.price as item_price, order_details.quantity
from orders
join order_details on order_details.order_id = orders.id
join items on items.id = order_details.item_id
join customers on customers.id = orders.customer_id
where orders.id = 1;



