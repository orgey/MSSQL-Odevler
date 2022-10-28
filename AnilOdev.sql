INSERT INTO Categories (CategoryName) VALUES ('Urunsuz')
INSERT INTO Products (ProductName) VALUES ('Kategorisiz')
INSERT INTO Employees (LastName,FirstName) VALUES ('�al��kan','S�leyman')

-- Soru 1. �r�n� olmayan kategorilerin isimlerini listeleyin
select *
from Categories left join Products
on Categories.CategoryID=Products.CategoryID
where Products.CategoryID is null

--Soru 2. Herhangi bir kategoriye dahil olmayan �r�nlerin isimlerini listeyin
select *
from Categories right join Products
on Categories.CategoryID = Products.CategoryID
where Products.CategoryID is null

--A�a��daki 2 sorgu sonu�lar�nda CategoryName ve ProductName s�tunlar� yanyana g�sterilecek �ekilde listelenmesi beklenmektedir.
--Soru 3. T�m kategorileri ve t�m �r�nleri listeleyin
select CategoryName, ProductName
from Categories full join Products
on Categories.CategoryID=Products.CategoryID

--Soru 4. �r�n� olmayan kategorileri ve kategorisi olmayan �r�nleri listeleyin
select CategoryName,ProductName
from Products full join Categories
on Products.CategoryID = Categories.CategoryID
where Products.CategoryID is null

--Soru 5. Sat�� yapan �al��anlar�n ka� adet �r�n sat��� yapt�klar�n�, 
--�al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, 
--satt��� �r�n adedini 'Sat�� Adedi' ba�l�kl� kolonda olacak �ekilde listeleyin
select FirstName + ' ' + LastName as 'Personel', COUNT(Orders.EmployeeID) ' Satis Adedi'
from Employees left join Orders
on Employees.EmployeeID= Orders.EmployeeID
group by FirstName,LastName

--Soru 6. Sat�� yapan �al��anlar�n ne kadarl�k sat�� yapt�klar�n� (toplam sat�� tutar�), 
--�al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, 
--yapt��� toplam sat�� tutar� 'Toplam Sat��' ba�l�kl� kolonda olacak �ekilde listeleyin
select FirstName + ' ' + LastName as 'Personel', SUM(UnitPrice) as 'Toplam Satis'
from [Order Details] OD left join Orders O on OD.OrderID = O.OrderID
	left join Employees E on O.EmployeeID = E.EmployeeID
	group by FirstName,LastName

--Soru 7. T�m �al��anlar�n ne kadarl�k sat�� yapt�klar�n� (toplam sat�� tutar�), 
--�al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' 
--isimli tek bir kolonda, yapt��� toplam sat�� tutar� 'Toplam Sat��' ba�l�kl� kolonda olacak �ekilde listeleyin
select FirstName + ' ' + LastName 'Personel',SUM(OD.UnitPrice*OD.Quantity) as 'Toplam Satis'
from [Order Details] OD right join Orders O on OD.OrderID = O.OrderID
		right join Employees E on E.EmployeeID = O.EmployeeID 
group by FirstName, LastName

--Soru 8. Hangi kategoriden toplam ne kadarl�k sipari� verilmi� listeleyin
select CategoryName, SUM(OD.UnitPrice*OD.Quantity) 'Toplam Siparis Tutari'
from [Order Details] OD right join Products P on OD.ProductID = P.ProductID 
	right join Categories C on C.CategoryID=P.ProductID 
	group by CategoryName

--Soru 9. Hangi m��teri toplam ne kadarl�k sipari� vermi�
select CompanyName, SUM(OD.UnitPrice*OD.Quantity)
from [Order Details] OD left join Orders O on OD.OrderID = O.OrderID
right join Customers C on O.CustomerID = C.CustomerID
group by CompanyName
--Soru 10. Hangi m��teri hangi kategorilerden sipari� vermi� 
select CompanyName, CategoryName 
from Customers Cs left join Orders O on Cs.CustomerID = O.CustomerID
	left join [Order Details] OD on OD.OrderID = O.OrderID
	left join Products P on P.ProductID = OD.ProductID
	left join Categories Ct on Ct.CategoryID = P.CategoryID
	 
--Soru 11. En �ok sat�lan �r�n�n tedarik�isi hangi firma
select TOP 1 S.CompanyName, P.ProductName, SUM(OD.Quantity) 'En Cok Satilan Urun Adedi'
from [Order Details] OD right join Products P on OD.ProductID = P.ProductID
		right join Suppliers S on P.SupplierID = S.SupplierID
		group by S.CompanyName, P.ProductName
		order by 'En Cok Satilan Urun Adedi' DESC

--Soru 12. Hangi �r�nden ka� adet sat�lm��
select ProductName, SUM(OD.Quantity) 'Satis Adedi'
from [Order Details] OD right join Products P on OD.ProductID=P.ProductID
group by ProductName
order by 'Satis Adedi' DESC

--Soru 13. En �ok sat�lan �r�n hangisi
select TOP 1 ProductName, SUM(OD.Quantity) 'Satis Adedi'
from [Order Details] OD right join Products P on OD.ProductID=P.ProductID
group by ProductName
order by 'Satis Adedi' DESC

--Soru 14. Stokta 20 birim alt�nda kalan �r�nlerin isimleri ve tedarik�i firma ad�n� listeleyin 
 select ProductName,S.CompanyName,P.UnitsInStock
 from Suppliers S right join Products P
 on S.SupplierID = P.SupplierID
 where P.UnitsInStock<20