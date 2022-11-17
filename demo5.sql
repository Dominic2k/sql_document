create database buoi_cuoi
use buoi_cuoi
--Bảng lớp 
create table lop(
ma int identity,
ten nvarchar(20)not null unique,
primary key(ma)
)
insert into lop(ten)
values('LT'),('ATTT'),('BTMT')

drop table lop

--Bảng sinh viên
create table sinh_vien(
ma int identity,
ten nvarchar(50) not null,
ma_lop int,
foreign key(ma_lop) references lop(ma),
constraint CK_do_dai_ten check(len(ten) >= 2),
primary key(ma)
)
insert into sinh_vien(ten, ma_lop)
values
('Long',1),(N'Tuấn',1),(N'Anh',2)

insert into sinh_vien(ten, ma_lop)
values
(N'Ski long',null)

--Bảng môn học
 create table mon(
ma int identity,
ten nvarchar(20)not null unique,
primary key(ma)
)

insert into mon(ten)
values
('SQL'),('PHP'),('HTML')
--Bảng điểm
create table diem(
ma_mon int not null,
ma_sinh_vien int not null,
diem float,
constraint CK_diem check(diem >= 0 and diem <= 10),
foreign key(ma_sinh_vien) references sinh_vien(ma), 
foreign key(ma_mon) references mon(ma), 
primary key(ma_mon,ma_sinh_vien)
)

insert into diem
values
(1,1,3),(1,2,5)

insert into diem
values
(2,1,10)

--Lấy tất cả sinh viên kèm thông tin lớp (nếu có)

select * 
from sinh_vien
left join lop on lop.ma = sinh_vien.ma_lop

--Đếm số sinh viên theo từng lớp
select * from lop
select * from sinh_vien

select
lop.ma,
lop.ten,
count (sinh_vien.ma_lop) from sinh_vien
right join lop on lop.ma = sinh_vien.ma_lop
group by lop.ma,lop.ten

--Lấy sinh viên có điểm 
select
sinh_vien.ten,
diem.diem,
mon.ten
from sinh_vien
join diem on diem.ma_sinh_vien = sinh_vien.ma
join mon on mon.ma = diem.ma_mon

--Lấy tất cả sinh viên, kèm điểm nếu có)

select
sinh_vien.ten,
diem.diem
from sinh_vien
left join diem on diem.ma_sinh_vien = sinh_vien.ma

-- Lấy điểm trung bình của sinh viên từng lớp 

select
lop.ma,
avg(diem)
from sinh_vien
join diem
on diem.ma_sinh_vien = sinh_vien.ma
right join lop 
on lop.ma = sinh_vien.ma_lop
group by lop.ma

-- Lấy điểm trung bình của sinh viên lớp LT

select
lop.ten,
avg(diem)
from sinh_vien
join diem
on diem.ma_sinh_vien = sinh_vien.ma
right join lop 
on lop.ma = sinh_vien.ma_lop
where lop.ten = 'LT'
group by lop.ten

--Lấy điểm trung bình của sinh viên môn SQL
--saiiiiiiiiiiiiii!!!!!!
--select
--mon.ten,
--avg(diem)
--from sinh_vien
--join diem
--on diem.ma_sinh_vien = sinh_vien.ma
--right join mon 
--on mon.ma = sinh_vien.ma
--where mon.ten = 'SQL'
--group by mon.ten 

--Hoặc

select
avg(diem) from sinh_vien
join diem on diem.ma_sinh_vien = sinh_vien.ma
right join mon on mon.ma = diem.ma_mon
where 
mon.ten = 'SQL'
-- hoặc
select avg(diem) from mon
left join diem on diem.ma_mon = mon.ma
where mon.ten = 'SQL'
--end bài tập