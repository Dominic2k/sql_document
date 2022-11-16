--Ban lãnh d?o thành ph? yêu c?u b?n t?o b?ng luu các con v?t trong s? thú
drop table con_vat

create table con_vat(
ma int identity,
ten varchar(20) not null,
so_chan int default 0,
moi_truong_song varchar (30),
tuoi_tho int,
constraint CK_ten check(len(ten) >= 2),
constraint CK_tuoi_tho check(tuoi_tho > 0),
constraint CK_so_chan check(so_chan >= 0 and so_chan % 2 = 0),
primary key (ma)
)
--V?i di?u ki?n t? b?n quy u?c (hãy áp d?ng check và default)

--S? thú hi?n có 7 con
insert into con_vat(ten,so_chan,moi_truong_song,tuoi_tho)
values
(N'Bò',4,N'Trên c?n',20),
(N'Gà',2,N'Trên c?n',10),
(N'Chó',4,N'Trên c?n',15),
(N'Ran',default,N'Trên c?n',12),
(N'Cá',default,N'Du?i nu?c',3),
(N'Chim',2,N'Trên không',5),
(N'Con ngu?i',2,N'Trên c?n',80)

--Th?ng kê có bao nhiêu con 4 chân
select count (*) as so_con
from con_vat
where so_chan = 4
--Th?ng kê s? con tuong ?ng v?i s? chân
select so_chan, count (*) as so_con
from con_vat
group by so_chan
--Th?ng kê s? con theo môi tru?ng s?ng
select moi_truong_song, count (*) as so_con
from con_vat
group by moi_truong_song
--Th?ng kê tu?i th? trung bình theo môi tru?ng s?ng
select moi_truong_song,
avg(tuoi_tho) as tuoi
from con_vat
group by moi_truong_song
--L?y ra 3 con có tu?i th? th? cao nh?t
-- B? qua 3 con v?a r?i d? l?y nh?ng con ti?p theo
-- sau offset là b? qua bao nhiêu b?n ghi và sau fetch là l?y bao nhiêu th?ng
--select *ffrom con_vat
--order by tuoi_tho desc 
--OFFSET 1 row
--fetch first 1 row only
-- ho?c
--select * from con_vat
--order by tuoi_tho desc 
--limit 1 offset 1
-- ng?n h?n 
-- limit1,1
--không có offset là k b? qua th?ng nào l?y h?t

select top 3 *
from con_vat
order by tuoi_tho desc

--(*) Tách nh?ng thông tin trên thành 2 b?ng cho d? qu?n lý (1 môi tru?ng s?ng g?m nhi?u con)
--end