--Ban l�nh d?o th�nh ph? y�u c?u b?n t?o b?ng luu c�c con v?t trong s? th�
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
--V?i di?u ki?n t? b?n quy u?c (h�y �p d?ng check v� default)

--S? th� hi?n c� 7 con
insert into con_vat(ten,so_chan,moi_truong_song,tuoi_tho)
values
(N'B�',4,N'Tr�n c?n',20),
(N'G�',2,N'Tr�n c?n',10),
(N'Ch�',4,N'Tr�n c?n',15),
(N'Ran',default,N'Tr�n c?n',12),
(N'C�',default,N'Du?i nu?c',3),
(N'Chim',2,N'Tr�n kh�ng',5),
(N'Con ngu?i',2,N'Tr�n c?n',80)

--Th?ng k� c� bao nhi�u con 4 ch�n
select count (*) as so_con
from con_vat
where so_chan = 4
--Th?ng k� s? con tuong ?ng v?i s? ch�n
select so_chan, count (*) as so_con
from con_vat
group by so_chan
--Th?ng k� s? con theo m�i tru?ng s?ng
select moi_truong_song, count (*) as so_con
from con_vat
group by moi_truong_song
--Th?ng k� tu?i th? trung b�nh theo m�i tru?ng s?ng
select moi_truong_song,
avg(tuoi_tho) as tuoi
from con_vat
group by moi_truong_song
--L?y ra 3 con c� tu?i th? th? cao nh?t
-- B? qua 3 con v?a r?i d? l?y nh?ng con ti?p theo
-- sau offset l� b? qua bao nhi�u b?n ghi v� sau fetch l� l?y bao nhi�u th?ng
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
--kh�ng c� offset l� k b? qua th?ng n�o l?y h?t

select top 3 *
from con_vat
order by tuoi_tho desc

--(*) T�ch nh?ng th�ng tin tr�n th�nh 2 b?ng cho d? qu?n l� (1 m�i tru?ng s?ng g?m nhi?u con)
--end