--1. �al��anlar�m�z ka� farkl� �ehirde �al���yorlar
select DISTINCT City from Employees E
where City is not null
--2. Adresleri i�inde 'House' kelimesi ge�en �al��anlar
select FirstName,LastName,E.Address 
from Employees E 
where E.Address like '%House%'
--3. Herhangi bir b�lge (Region) verisi olmayan �al��anlar
select FirstName,LastName,Region from Employees E
where Region is null
--4. �al��anlar� adlar�n� A-Z soyadlar�n� Z-A olaracak �ekilde tek sorguda listeleyelim
select FirstName,LastName from Employees
order by FirstName ASC,LastName DESC
--5. �r�nleri; �r�n ad�, Fiyat�, KDV tutar�, KDV Dahil fiyat� �eklinde listeleyelim (KDV %18 olacak) 
select ProductName,UnitPrice, UnitPrice*0.18 'KDV',UnitPrice*1.18 'KDV Dahil Fiyat' from Products
--6. En pahal� 5 �r�n� listeyelim
select top 5 ProductName,UnitPrice from Products
order by UnitPrice desc
--7. Stok adedi 20-50 aras�ndaki �r�nlerin listesi
select ProductName,UnitsInStock from Products
where UnitsInStock between 20 and 50
--8. Hangi �lkede ka� m��terimiz var
select Country,COUNT(Country) from Customers
group by Country
--9. Her kategoride ka� kalem �r�n var (kategori ad�, o kategorideki toplam �r�n kalemi say�s�)
select CategoryName, COUNT(CategoryName) 'Urun Adedi'
from Products P right join Categories C
on P.CategoryID = C.CategoryID
group by CategoryName
--10. Her kategoride ka� adet �r�n var (kategori ad�, o kategorideki toplam �r�n adedi (stock) say�s�)
select CategoryName, SUM(UnitsInStock) 'Urun Adedi'
from Products P right join Categories C
on P.CategoryID = C.CategoryID
group by CategoryName
--11. 50 den fazla sipari� alan personellerin ad, soyad, sipari� adedi �eklinde listeleyelim
select FirstName,LastName, COUNT(OrderID) 'Toplam Siparis'
from Orders O right join Employees E
on O.EmployeeID=E.EmployeeID
group by FirstName,LastName
having COUNT(OrderID)>50
--12. Sat�� yap�lmayan �r�n adlar�n�n listesi
select ProductName,COUNT(OrderID) from Products p
left join [Order Details] od on p.ProductID=od.ProductID
group by ProductName
having COUNT(OrderID) = 0
--13. Ortalaman�n alt�nda bir fiyata sahip olan �r�nlerin ad� ve fiyat�
--??
--14. Hi� sipari� vermeyen m��teriler
select CompanyName
from Customers C left join Orders O
on C.CustomerID=O.CustomerID
group by CompanyName
having SUM(O.OrderID) is null
--15. Hangi tedarik�i hangi �r�n� sa�l�yor
select s.CompanyName, p.ProductName
from Suppliers s left join Products p
on s.SupplierID = p.SupplierID