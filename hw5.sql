-- 1 
use `cs431_sporting_goods`;
DROP PROCEDURE IF EXISTS test;
DELIMITER //test_2
CREATE PROCEDURE test ()
BEGIN
declare sqlerr tinyint default false;
declare continue handler for 1062 set sqlerr = TRUE;
start transaction;
delete from athlete_order_items where order_id in
(select order_id from athlete_orders where athlete_id=8);
delete from athlete_orders where athlete_id=8;
delete from athlete_addresses where athlete_id=8;
delete from athletes where athlete_id=8;

if sqlerr=false then
commit;
select 'Transaction Committed' as msg;
else
rollback;
select 'Transaction Rollbacked' as msg;
end if;
end //
delimiter ;
call test();


-- 2 
use `cs431_sporting_goods`;
#delete the procedure test if it exists.
DROP PROCEDURE IF EXISTS test;

DELIMITER //
CREATE PROCEDURE test ()
BEGIN
declare order_id int(11);
declare sqlerr tinyint default false;
declare continue handler for 1062 set sqlerr = TRUE;
start transaction;
INSERT INTO athlete_orders VALUES(DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4,
'American Express', '378282246310005', '04/2013', 4);
SELECT LAST_INSERT_ID() INTO order_id;
INSERT INTO athlete_order_items VALUES(DEFAULT, order_id, 6, '415.00', '161.85', 1);
INSERT INTO athlete_order_items VALUES(DEFAULT, order_id, 1, '699.00', '209.70', 1);
if sqlerr=FALSE then
commit;
select 'Transaction Committed' as msg;
else
rollback;
select 'Transaction rollbacked' as msg;
end if;
end //
delimiter ;
call test();

-- 3 
use `cs431_sporting_goods`;
DROP PROCEDURE IF EXISTS test;
DELIMITER //
CREATE PROCEDURE test ()
BEGIN
declare sqlerr tinyint default false;
declare continue handler for 1062 set sqlerr = TRUE;
#start transaction
start transaction;
delete from athlete_order_items where order_id in
(select order_id from athlete_orders where athlete_id=6);
delete from athlete_orders where athlete_id=6;
  delete from athlete_addresses where athlete_id=6;
  delete from athletes where athlete_id=6;
 
if sqlerr=FALSE then
commit;
select 'Transaction Committed' as msg;
else
rollback;
select 'Transaction rollbacked' as msg;
end if;
end //
delimiter ;
call test();


