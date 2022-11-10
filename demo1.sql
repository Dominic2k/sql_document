create database quan_li_khach_hang
use quan_li_khach_hang

create table khach_hang(
ma int identity,
ho_ten nvarchar(50) not null,
so_dien_thoai char(15) unique not null,
dia_chi ntext not null,
gioi_tinh bit not null,
ngay_sinh date not null,
primary key(ma)
)
--Thêm 5 khách hàng
insert into khach_hang(ho_ten,so_dien_thoai,dia_chi,gioi_tinh,ngay_sinh)
values
(N'Nguyễn Văn Long','63646366','HP',1,'2000-01-10'),
(N'Phạm Văn Tuấn','73729737249','HN',1,'1999-01-01'),
(N'Trương Văn Anh','972293','QN',1,'1998-01-01'),
(N'Lê Thị Minh','827284274','LA',0,'1997-01-01'),
(N'Trần Văn Đức','787283792','LC',1,'1996-01-01')

--Hiển thị chỉ học tên và sdt của tất cả khách hàng

select ho_ten, so_dien_thoai
from khach_hang

--Cập nhật khách có mã là 2 sang tên tuấn

update khach_hang set ho_ten = N'Tuấn' where ma = 2

--Xóa khách hàng có mã lớn hơn 3 và giới tính là Nam
delete from khach_hang where ma > 3 and gioi_tinh = 1
-- Lấy ra khách hàng sinh tháng 1
select * from khach_hang
where MONTH(ngay_sinh) = 1

--Lấy ra khách hàng có tên trong danh sách (Anh ,Minh,Đức) và gipwof tính Nam hoặc chỉ cần năm sinh trước 2000

select * from khach_hang
where (ho_ten in ('Anh', 'Minh','Đức') and gioi_tinh =1) or year(ngay_sinh) < 2000

-- Lấy ra khách hàng có tuổi lớn hơn 18

select * from khach_hang
where YEAR(GETDATE()) - year(ngay_sinh) > 23

--Lấy ra 3 khách hàng mới nhất (giảm dần:asc)
select top 3 * from khach_hang
order by ma desc

--Lấy ra khách hàng có tên chứa chữ T( trong My sql không phân biệt unicode)

select * from khach_hang
where ho_ten like '%T%'

--Thay đổi bảng sao cho chỉ nhập được ngày sinh bé hớn ngày sinh hiện tại
-- thêm constraint + tên check để sau kiểm tra lỗi
alter table khach_hang
add check(ngay_sinh < GETDATE())

--Thay đổi bảng sao cho chỉ cho nhập được giới tính nam với bạn tên Long

alter table khach_hang
add check((gioi_tinh = 1 and ho_ten = 'Long') or ho_ten != 'Long')
-- dèault
alter table khach_hang
ADD CONSTRAINT gioi_tinh_mac_dinh
default 1 for gioi_tinh
--End bài tập
