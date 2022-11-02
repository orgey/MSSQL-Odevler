--1. Çalýþanlarýmýz kaç farklý þehirde çalýþýyorlar
select DISTINCT City from Employees E
where City is not null
--2. Adresleri içinde 'House' kelimesi geçen çalýþanlar
select FirstName,LastName,E.Address 
from Employees E 
where E.Address like '%House%'
--3. Herhangi bir bölge (Region) verisi olmayan çalýþanlar
select FirstName,LastName,Region from Employees E
where Region is null
--4. Çalýþanlarý adlarýný A-Z soyadlarýný Z-A olaracak þekilde tek sorguda listeleyelim
select FirstName,LastName from Employees
order by FirstName ASC,LastName DESC
--5. Ürünleri; ürün adý, Fiyatý, KDV tutarý, KDV Dahil fiyatý þeklinde listeleyelim (KDV %18 olacak) 
select ProductName,UnitPrice, UnitPrice*0.18 'KDV',UnitPrice*1.18 'KDV Dahil Fiyat' from Products
--6. En pahalý 5 ürünü listeyelim
select top 5 ProductName,UnitPrice from Products
order by UnitPrice desc
--7. Stok adedi 20-50 arasýndaki ürünlerin listesi
select ProductName,UnitsInStock from Products
where UnitsInStock between 20 and 50
--8. Hangi ülkede kaç müþterimiz var
select Country,COUNT(Country) from Customers
group by Country
--9. Her kategoride kaç kalem ürün var (kategori adý, o kategorideki toplam ürün kalemi sayýsý)
select CategoryName, COUNT(CategoryName) 'Urun Adedi'
from Products P right join Categories C
on P.CategoryID = C.CategoryID
group by CategoryName
--10. Her kategoride kaç adet ürün var (kategori adý, o kategorideki toplam ürün adedi (stock) sayýsý)
select CategoryName, SUM(UnitsInStock) 'Urun Adedi'
from Products P right join Categories C
on P.CategoryID = C.CategoryID
group by CategoryName
--11. 50 den fazla sipariþ alan personellerin ad, soyad, sipariþ adedi þeklinde listeleyelim
select FirstName,LastName, COUNT(OrderID) 'Toplam Siparis'
from Orders O right join Employees E
on O.EmployeeID=E.EmployeeID
group by FirstName,LastName
having COUNT(OrderID)>50
--12. Satýþ yapýlmayan ürün adlarýnýn listesi
select ProductName,COUNT(OrderID) from Products p
left join [Order Details] od on p.ProductID=od.ProductID
group by ProductName
having COUNT(OrderID) = 0
--13. Ortalamanýn altýnda bir fiyata sahip olan ürünlerin adý ve fiyatý
--??
--14. Hiç sipariþ vermeyen müþteriler
select CompanyName
from Customers C left join Orders O
on C.CustomerID=O.CustomerID
group by CompanyName
having SUM(O.OrderID) is null
--15. Hangi tedarikçi hangi ürünü saðlýyor
select s.CompanyName, p.ProductName
from Suppliers s left join Products p
on s.SupplierID = p.SupplierID