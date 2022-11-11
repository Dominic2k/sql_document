create table nhan_vien(
ma int identity,
ten nvarchar(50) not null,
ngay_sinh date not null,
gioi_tinh bit default 0 not null,
ngay_vao_lam date default getdate() not null,
nghe_nghiep nvarchar(50) not null,
luong int not null,
constraint CK_luong_nguyen_duong check (luong >= 0),
constraint CK_do_dai_ten check(len(ten) > 2),
constraint CK_tuoi check(year(getdate()) - year(ngay_sinh) > 18),
constraint CK_nghe check(nghe_nghiep in ('IT',N'Doanh nhân thành đạt',N'Kế toán')),
primary key(ma)
)

insert into nhan_vien(ten,ngay_sinh,gioi_tinh,ngay_vao_lam,nghe_nghiep,luong)
values
('Long','1997-01-01',1,default,'IT',100),
(N'Tuấn','1998-01-01',1,default,N'Doanh nhân thành đạt',200),
(N'Đạt','1997-09-01',0,default, N'Kế toán',20),
(N'Qúy','1997-11-11',0,default, N'Kế toán',30)

--cập nhật cho nhân viên sinh tháng này tăng lương 100
update nhan_vien
set luong = 100
where
month(ngay_sinh) = month(getdate())

select * from nhan_vien
where month(ngay_sinh) = month(getdate())
-- tăng tất cả nhân viên 100 luong
update nhan_vien
set luong = luong + 100
--hoặc là luong += 100 
--xóa nhân viên nào có lương dươi 50
delete from nhan_vien
where luong < 50
--dịch nên nghi nên xóa cả ai mới lên 100 nếu lương cũ nhỏ hơn 50, dduoi cả nhân vien vào làm dưới  2 tháng

delete from nhan_vien
where luong < 50 + 100
and
month(ngay_sinh) = month(getdate())
-- đuổi nhân viên mới vào 2 tháng

delete from nhan_vien
where
datediff(month,ngay_vao_lam,getdate()) < 2
and ngay_vao_lam < getdate()

select * from nhan_vien
-- lấy ra tổng tiền sếp phải trả cho nhân viên
select sum(luong) from nhan_vien
-- theo từng nghề
select nghe_nghiep,sum(luong) as tong_luong from nhan_vien
group by nghe_nghiep
--lấy ra trung bình lương nhân vien
select avg(luong) from nhan_vien
--theo từng nghề
-- lấy ra các bạn mứi vào làm hômnsy
select * from nhan_vien
where
--ngay_vao_lam = CAST( GETDATE() as date )
datediff(day,ngay_vao_lam,getdate()) = 0

--lấy ra 3 bạn nhân viên cũ nhât

select top 3 * from nhan_vien
order by ngay_vao_lam asc

-- lấy tiếp 3 bạn mà bỏ qua 3 bạn trước đó
select * from nhan_vien
order by ngay_vao_lam asc
OFFSET 3 rows
fetch next 3 rows only;

--Mysql
--select * from nhan_vien
--order by ngay_vao_lam asc
--limit 3 3

-- end_bai_tap