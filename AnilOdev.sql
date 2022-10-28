INSERT INTO Categories (CategoryName) VALUES ('Urunsuz')
INSERT INTO Products (ProductName) VALUES ('Kategorisiz')
INSERT INTO Employees (LastName,FirstName) VALUES ('Çalýþkan','Süleyman')

-- Soru 1. Ürünü olmayan kategorilerin isimlerini listeleyin
select *
from Categories left join Products
on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

--Soru 2. Herhangi bir kategoriye dahil olmayan ürünlerin isimlerini listeyin
select *
from Categories right join Products
on Categories.CategoryID = Products.CategoryID
where Products.CategoryID is null

--Aþaðýdaki 2 sorgu sonuçlarýnda CategoryName ve ProductName sütunlarý yanyana gösterilecek þekilde listelenmesi beklenmektedir.
--Soru 3. Tüm kategorileri ve tüm ürünleri listeleyin
select CategoryName, ProductName
from Categories full join Products
on Categories.CategoryID=Products.CategoryID

--Soru 4. Ürünü olmayan kategorileri ve kategorisi olmayan ürünleri listeleyin
select CategoryName,ProductName
from Products full join Categories
on Products.CategoryID = Categories.CategoryID
where Products.CategoryID is null

--Soru 5. Satýþ yapan çalýþanlarýn kaç adet ürün satýþý yaptýklarýný, 
--çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, 
--sattýðý ürün adedini 'Satýþ Adedi' baþlýklý kolonda olacak þekilde listeleyin
select FirstName + ' ' + LastName as 'Personel', COUNT(Orders.EmployeeID) ' Satis Adedi'
from Employees left join Orders
on Employees.EmployeeID= Orders.EmployeeID
group by FirstName,LastName

--Soru 6. Satýþ yapan çalýþanlarýn ne kadarlýk satýþ yaptýklarýný (toplam satýþ tutarý), 
--çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, 
--yaptýðý toplam satýþ tutarý 'Toplam Satýþ' baþlýklý kolonda olacak þekilde listeleyin
select FirstName + ' ' + LastName as 'Personel', SUM(UnitPrice) as 'Toplam Satis'
from [Order Details] OD left join Orders O on OD.OrderID = O.OrderID
	left join Employees E on O.EmployeeID = E.EmployeeID
	group by FirstName,LastName

--Soru 7. Tüm çalýþanlarýn ne kadarlýk satýþ yaptýklarýný (toplam satýþ tutarý), 
--çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' 
--isimli tek bir kolonda, yaptýðý toplam satýþ tutarý 'Toplam Satýþ' baþlýklý kolonda olacak þekilde listeleyin
select FirstName + ' ' + LastName 'Personel',SUM(OD.UnitPrice*OD.Quantity) as 'Toplam Satis'
from [Order Details] OD right join Orders O on OD.OrderID = O.OrderID
		right join Employees E on E.EmployeeID = O.EmployeeID 
group by FirstName, LastName

--Soru 8. Hangi kategoriden toplam ne kadarlýk sipariþ verilmiþ listeleyin
select CategoryName, SUM(OD.UnitPrice*OD.Quantity) 'Toplam Siparis Tutari'
from [Order Details] OD right join Products P on OD.ProductID = P.ProductID 
	right join Categories C on C.CategoryID=P.ProductID 
	group by CategoryName

--Soru 9. Hangi müþteri toplam ne kadarlýk sipariþ vermiþ
select CompanyName, SUM(OD.UnitPrice*OD.Quantity)
from [Order Details] OD left join Orders O on OD.OrderID = O.OrderID
right join Customers C on O.CustomerID = C.CustomerID
group by CompanyName
--Soru 10. Hangi müþteri hangi kategorilerden sipariþ vermiþ 
select CompanyName, CategoryName 
from Customers Cs left join Orders O on Cs.CustomerID = O.CustomerID
	left join [Order Details] OD on OD.OrderID = O.OrderID
	left join Products P on P.ProductID = OD.ProductID
	left join Categories Ct on Ct.CategoryID = P.CategoryID
	 
--Soru 11. En çok satýlan ürünün tedarikçisi hangi firma
select TOP 1 S.CompanyName, P.ProductName, SUM(OD.Quantity) 'En Cok Satilan Urun Adedi'
from [Order Details] OD right join Products P on OD.ProductID = P.ProductID
		right join Suppliers S on P.SupplierID = S.SupplierID
		group by S.CompanyName, P.ProductName
		order by 'En Cok Satilan Urun Adedi' DESC

--Soru 12. Hangi üründen kaç adet satýlmýþ
select ProductName, SUM(OD.Quantity) 'Satis Adedi'
from [Order Details] OD right join Products P on OD.ProductID=P.ProductID
group by ProductName
order by 'Satis Adedi' DESC

--Soru 13. En çok satýlan ürün hangisi
select TOP 1 ProductName, SUM(OD.Quantity) 'Satis Adedi'
from [Order Details] OD right join Products P on OD.ProductID=P.ProductID
group by ProductName
order by 'Satis Adedi' DESC

--Soru 14. Stokta 20 birim altýnda kalan ürünlerin isimleri ve tedarikçi firma adýný listeleyin 
 select ProductName,S.CompanyName,P.UnitsInStock
 from Suppliers S right join Products P
 on S.SupplierID = P.SupplierID
 where P.UnitsInStock<20