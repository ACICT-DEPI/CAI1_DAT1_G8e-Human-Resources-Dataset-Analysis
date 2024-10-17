--Exploratory Data Analysis
Select * From [HumanResources].[Employee]
Select * From [HumanResources].[EmployeePayHistory]
Select * From [HumanResources].[Department]
Select * From [HumanResources].[EmployeeDepartmentHistory]
Select * From [HumanResources].[JobCandidate]
Select * From [HumanResources].[Shift]
Select * From[Purchasing].[PurchaseOrderHeader]
Select * From[Purchasing].[PurchaseOrderDetail]
Select * From[Purchasing].[ShipMethod]
Select * From[Purchasing].[Vendor]
Select * From[Purchasing].[ProductVendor]
--Data Cleaning 
--Missing Values,Outliers And Errors

--Human Resources
Select * From [HumanResources].[Employee]
Select * From [HumanResources].[EmployeePayHistory]
Select * From [HumanResources].[Department]
Select * From [HumanResources].[EmployeeDepartmentHistory]
Select * From [HumanResources].[JobCandidate]
Select * From [HumanResources].[Shift]
--1. What is the total number of employees in the organization?
Select * From [HumanResources].[Employee]

Select Count(HRE.BusinessEntityID) AS TotalNumberOfEmployees
From [HumanResources].[Employee] HRE
--2. What is the average salary of employees in each department?
Select * From [HumanResources].[EmployeeDepartmentHistory]
Select * From [HumanResources].[Department]
Select * From [HumanResources].[EmployeePayHistory]

Select HRD.DepartmentID,HRD.Name,AVG(HRP.Rate) AS TheAverageSalary
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Department] HRD
On HRH.DepartmentID = HRD.DepartmentID
Left Join [HumanResources].[EmployeePayHistory] HRP
On HRH.BusinessEntityID = HRP.BusinessEntityID
Group by HRD.DepartmentID,HRD.Name
--3. Which department has the highest number of employees?
 Select * From [HumanResources].[EmployeeDepartmentHistory]

 Select TOP 3 HRD.Name,COUNT(HRH.BusinessEntityID) AS TotalNumberOfEmployees
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Department] HRD
 ON HRH.DepartmentID = HRD.DepartmentID
 Group by HRD.Name
 Order by TotalNumberOfEmployees Desc
--4. What is the average tenure of employees in each department?
 Select * From [HumanResources].[Department]
 Select * From [HumanResources].[EmployeeDepartmentHistory]

 Select HRD.DepartmentID,HRD.Name,
 AVG(DATEDIFF(MONTH,HRH.StartDate,ISNULL(HRH.EndDate,GETDATE()))) AS AverageTenure
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID
 Group by HRD.DepartmentID,HRD.Name
--5. What is the gender distribution  of employees in each department?
 Select * From [HumanResources].[Employee]
 Select * From [HumanResources].[Department]
 Select * From [HumanResources].[EmployeeDepartmentHistory]

 Select HRD.DepartmentID,HRD.Name AS DepartmentName,HRE.Gender,
 Count(HRE.BusinessEntityID) AS TotalNumberOfEmployees
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID 
 Group by HRD.DepartmentID,HRD.Name,HRE.Gender
 Order by TotalNumberOfEmployees Desc
--6. What is the average number of vacation hours taken by employees in each department?
 Select * From [HumanResources].[Employee]
 Select * From [HumanResources].[Department]
 Select * From [HumanResources].[EmployeeDepartmentHistory]

 Select HRD.DepartmentID,HRD.Name AS DepartmentName,
 AVG(HRE.VacationHours) AS AverageNumberOfVacationHours
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID 
 Group by HRD.DepartmentID,HRD.Name
 Order by AverageNumberOfVacationHours Desc
--7. What is the average number of sick leave hours taken by employees in each department?
 Select * From [HumanResources].[Employee]
 Select * From [HumanResources].[Department]
 Select * From [HumanResources].[EmployeeDepartmentHistory]

 Select HRD.DepartmentID,HRD.Name AS DepartmentName,
 AVG(HRE.SickLeaveHours) AS AverageNumberOfSickLeaveHours
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID 
 Group by HRD.DepartmentID,HRD.Name
 Order by AverageNumberOfSickLeaveHours Desc
--8. What is the average salary of employees in each job title?
Select * From [HumanResources].[Employee]
Select * From [HumanResources].[EmployeePayHistory]

Select HRE.JobTitle,AVG(HRP.Rate) AS AverageSalary
From [HumanResources].[Employee] HRE
Left Join [HumanResources].[EmployeePayHistory] HRP
On HRE.BusinessEntityID = HRP.BusinessEntityID
Group by HRE.JobTitle
Order by AverageSalary DESC
--9. What is the average number of years of service for employees in each job title?
Select * From [HumanResources].[Employee]
Select * From [HumanResources].[EmployeeDepartmentHistory]

 Select HRE.JobTitle,AVG(DATEDIFF(YEAR,HRH.StartDate,ISNULL(HRH.EndDate,GETDATE()))) AS Average
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Group by HRE.JobTitle
--10. What is the average number of employees in each shift?
Select HRS.ShiftID,HRS.Name,Count(BusinessEntityID) AS AverageNumberOfEmployees
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Shift] HRS
On HRH.ShiftID = HRS.ShiftID
Group by HRS.ShiftID,HRS.Name
Order by AverageNumberOfEmployees

--Procurement
Select * From[Purchasing].[PurchaseOrderHeader]
Select * From[Purchasing].[PurchaseOrderDetail]
Select * From[Purchasing].[ShipMethod]
Select * From[Purchasing].[Vendor]
Select * From[Purchasing].[ProductVendor]
--11. What is the total number of purchase orders placed in the last quarter?
Select Count(POH.PurchaseOrderID) AS TotalNumberOfPurchaseOrder
From [Purchasing].[PurchaseOrderHeader] POH
where OrderDate>=DATEADD(QUARTER,-1,GETDATE())
--12. What is the average total due for each purchase order?
Select POH.PurchaseOrderID,PV.Name,Sum(POH.TotalDue) AS AverageTotalDue
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by POH.PurchaseOrderID,PV.Name
Order by AverageTotalDue Desc
--13. Which vendor has the highest total due for all purchase orders?
Select TOP 1 POH.PurchaseOrderID,PV.Name,Sum(POH.TotalDue) AS AverageTotalDue
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by POH.PurchaseOrderID,PV.Name
Order by AverageTotalDue Desc
--14. What is the average number of days between order date and ship date?
Select PV.BusinessEntityID,AVG(DATEDIFF(DAY,POH.OrderDate,POH.ShipDate)) AS AverageNumberOfDays
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by PV.BusinessEntityID
--15. What is the average number of products ordered per purchase order?
Select POD.PurchaseOrderID,Count(POD.OrderQty) AS AverageNumberOfProductOrderd
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductOrderd Desc
--16. What is the average unit price of products ordered?
Select POD.PurchaseOrderID,AVG(POD.UnitPrice) AS AverageUnitsPriceOfProductOrdered
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageUnitsPriceOfProductOrdered Desc
--17. What is the average number of products received per purchase order?
Select POD.PurchaseOrderID,AVG(POD.ReceivedQty) AS AverageNumberOfProductReceived
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductReceived Desc
--18. What is the average number of products rejected per purchase order?
Select POD.PurchaseOrderID,AVG(POD.RejectedQty) AS AverageNumberOfProductRejected
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductRejected Desc
--19. What is the average number of products stocked per purchase order?
Select POD.PurchaseOrderID,AVG(POD.StockedQty) AS AverageNumberOfProductStocked
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductStocked Desc
--20. What is the average lead time for each product?
Select PV.ProductID,AVG(PV.AverageLeadTime) AS AverageLeadTime
From [Purchasing].[ProductVendor] PV
Group by PV.ProductID
Order by PV.ProductID

--Linking Tables
Select * From [HumanResources].[Employee]
Select * From [HumanResources].[EmployeePayHistory]
Select * From [HumanResources].[Department]
Select * From [HumanResources].[EmployeeDepartmentHistory]
Select * From [HumanResources].[JobCandidate]
Select * From [HumanResources].[Shift]
Select * From[Purchasing].[PurchaseOrderHeader]
Select * From[Purchasing].[PurchaseOrderDetail]
Select * From[Purchasing].[ShipMethod]
Select * From[Purchasing].[Vendor]
Select * From[Purchasing].[ProductVendor]
--21. What is the average number of employees in each department, and what is the average salary of those employees?
Select HRD.DepartmentID,HRD.Name,Count(HRE.BusinessEntityID) AS AverageNumberOfEmployee,
AVG(HRP.Rate) AS AverageSalaryOfEmployee
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Employee] HRE
On HRH.BusinessEntityID = HRE.BusinessEntityID
Left Join [HumanResources].[EmployeePayHistory] HRP
On HRH.BusinessEntityID = HRP.BusinessEntityID
Left Join [HumanResources].[Department] HRD
On HRH.DepartmentID = HRD.DepartmentID
Group by HRD.DepartmentID,HRD.Name
--22. What is the average number of purchase orders placed by each employee, and what is the average total due for those orders?
Select POH.EmployeeID,Count(POH.PurchaseOrderID) AS AverageNumbersOfPurchaseOrders ,
Sum(POH.TotalDue) AS AverageTotalDueForOrders
From [Purchasing].[PurchaseOrderHeader] POH
Group by POH.EmployeeID
--23. What is the average number of products ordered by each vendor, and what is the average unit price of those products?
Select POH.VendorID,PV.Name,Count(POD.OrderQty) AS AverageNumberOfProductOrdered, 
AVG(POD.UnitPrice) AS AverageUnitPriceProduct
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[PurchaseOrderDetail] POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by POH.VendorID,PV.Name
Order by VendorID 
--24. What is the average number of days between order date and ship date for each vendor?
Select PV.Name,AVG(DATEDIFF(DAY,POH.OrderDate,POH.ShipDate)) AS AverageNumberOfDays
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by PV.Name
--25. What is the average number of products received per purchase order for each vendor?
Select PV.BusinessEntityID,PV.Name,Count(POD.ReceivedQty) AS NumberOfProductsReceived
From [Purchasing].[PurchaseOrderHeader] POH
Left Join[Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Left Join [Purchasing].[PurchaseOrderDetail] POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Group by PV.BusinessEntityID,PV.Name
Order by NumberOfProductsReceived

--Creating Views
 --1
 --1. What is the total number of employees in the organization?
Create View TotalNumberOfEmployees AS
Select Count(HRE.BusinessEntityID) AS TotalNumberOfEmployees
From [HumanResources].[Employee] HRE;

Select * From TotalNumberOfEmployees
--2
--2. What is the average salary of employees in each department?
Create View TheAverageSalary AS 
Select HRD.DepartmentID,HRD.Name,AVG(HRP.Rate) AS TheAverageSalary
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Department] HRD
On HRH.DepartmentID = HRD.DepartmentID
Left Join [HumanResources].[EmployeePayHistory] HRP
On HRH.BusinessEntityID = HRP.BusinessEntityID
Group by HRD.DepartmentID,HRD.Name;

Select * From TheAverageSalary
--3
--3. Which department has the highest number of employees?
Create View NumberOfEmployeesByDepartment AS
 Select TOP 3 HRD.Name,COUNT(HRH.BusinessEntityID) AS TotalNumberOfEmployees
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Department] HRD
 ON HRH.DepartmentID = HRD.DepartmentID
 Group by HRD.Name
 Order by TotalNumberOfEmployees Desc;

 Select * From NumberOfEmployeesByDepartment
 --4
 --4. What is the average tenure of employees in each department?
Create View AverageTenure AS
Select HRD.DepartmentID,HRD.Name,
 AVG(DATEDIFF(MONTH,HRH.StartDate,ISNULL(HRH.EndDate,GETDATE()))) AS AverageTenure
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID
 Group by HRD.DepartmentID,HRD.Name;

 Select * From AverageTenure
 --5
 --5. What is the gender distribution  of employees in each department?
 Create View TotalNumberOfEmployeesByGenderAndDepartment AS
 Select Top 9 HRD.DepartmentID,HRD.Name AS DepartmentName,HRE.Gender,
 Count(HRE.BusinessEntityID) AS TotalNumberOfEmployees
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID 
 Group by HRD.DepartmentID,HRD.Name,HRE.Gender
 Order by TotalNumberOfEmployees Desc;

 Select * From TotalNumberOfEmployeesByGenderAndDepartment
 --6
 --6. What is the average number of vacation hours taken by employees in each department?
 Create View AverageNumberOfVacationHours AS  
 Select Top 9 HRD.DepartmentID,HRD.Name AS DepartmentName,
 AVG(HRE.VacationHours) AS AverageNumberOfVacationHours
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID 
 Group by HRD.DepartmentID,HRD.Name
 Order by AverageNumberOfVacationHours Desc

 Select * From AverageNumberOfVacationHours
 --7
 --7. What is the average number of sick leave hours taken by employees in each department?
 Create View AverageNumberOfSickLeaveHours AS
 Select Top 9 HRD.DepartmentID,HRD.Name AS DepartmentName,
 AVG(HRE.SickLeaveHours) AS AverageNumberOfSickLeaveHours
 From [HumanResources].[EmployeeDepartmentHistory] HRH
 Left Join [HumanResources].[Employee] HRE
 On HRH.BusinessEntityID = HRE.BusinessEntityID
 Left Join [HumanResources].[Department] HRD
 On HRH.DepartmentID = HRD.DepartmentID 
 Group by HRD.DepartmentID,HRD.Name
 Order by AverageNumberOfSickLeaveHours Desc

 Select * From AverageNumberOfSickLeaveHours
 --8
 --8. What is the average salary of employees in each job title?
 Create View AverageSalaryByJobTitle AS
 Select Top 9 HRE.JobTitle,AVG(HRP.Rate) AS AverageSalary
From [HumanResources].[Employee] HRE
Left Join [HumanResources].[EmployeePayHistory] HRP
On HRE.BusinessEntityID = HRP.BusinessEntityID
Group by HRE.JobTitle
Order by AverageSalary DESC

Select * From AverageSalaryByJobTitle
--9
--9. What is the average number of years of service for employees in each job title?
Create View YearsOfYearsByEachJobTitle AS
Select Top 9 HRE.JobTitle,AVG(DATEDIFF(YEAR,HRH.StartDate,ISNULL(HRH.EndDate,GETDATE()))) AS Average
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Employee] HRE
On HRH.BusinessEntityID = HRE.BusinessEntityID
Group by HRE.JobTitle
Order by Average Desc;

Select * From YearsOfYearsByEachJobTitle
--10
--10. What is the average number of employees in each shift?
Create View NumberOfEmployeesByEachShift AS
Select Top 3 HRS.ShiftID,HRS.Name,Count(BusinessEntityID) AS AverageNumberOfEmployees
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Shift] HRS
On HRH.ShiftID = HRS.ShiftID
Group by HRS.ShiftID,HRS.Name
Order by AverageNumberOfEmployees Desc

Select * From NumberOfEmployeesByEachShift
--11
--11. What is the total number of purch ase orders placed in the last quarter?
Create View TotalNumberOfPurchaseOrderByQuarter AS
Select Count(POH.PurchaseOrderID) AS TotalNumberOfPurchaseOrder
From [Purchasing].[PurchaseOrderHeader] POH
where OrderDate>=DATEADD(QUARTER,-1,OrderDate)

Select * From TotalNumberOfPurchaseOrderByQuarter
--12
--12. What is the average total due for each purchase order?
Create View AverageTotalDue AS
Select Top 5 POH.PurchaseOrderID,PV.Name,Sum(POH.TotalDue) AS AverageTotalDue
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by POH.PurchaseOrderID,PV.Name
Order by AverageTotalDue Desc

Select * From AverageTotalDue
--13
--13. Which vendor has the highest total due for all purchase orders?
Create View TopAverageTotalDue AS
Select TOP 1 POH.PurchaseOrderID,PV.Name,Sum(POH.TotalDue) AS AverageTotalDue
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by POH.PurchaseOrderID,PV.Name
Order by AverageTotalDue Desc

Select * From TopAverageTotalDue
--14
--14. What is the average number of days between order date and ship date?
Create View NumOfDaysBetweenOrderdateAndShipdate AS
Select Top 9 PV.BusinessEntityID,PV.Name,AVG(DATEDIFF(DAY,POH.OrderDate,POH.ShipDate)) AS AverageNumberOfDays
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by PV.BusinessEntityID,PV.Name
Order by AverageNumberOfDays Desc

Select *From NumOfDaysBetweenOrderdateAndShipdate
--15
--15. What is the average number of products ordered per purchase order?
 Create View AverageNumberOfProductOrderd AS
Select TOP 7 POD.PurchaseOrderID,PV.Name,Count(POD.OrderQty) AS AverageNumberOfProductOrderd
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[PurchaseOrderDetail] POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Left Join [Purchasing].[Vendor] PV
ON POH.VendorID=PV.BusinessEntityID
Group by POD.PurchaseOrderID,PV.Name
Order by AverageNumberOfProductOrderd Desc

Select * From AverageNumberOfProductOrderd
--16
--16. What is the average unit price of products ordered?
Create View AverageUnitsPriceOfProductOrdered AS
Select Top 5 POD.PurchaseOrderID,AVG(POD.UnitPrice) AS AverageUnitsPriceOfProductOrdered
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageUnitsPriceOfProductOrdered Desc

Select * From AverageUnitsPriceOfProductOrdered
--17
--17. What is the average number of products received per purchase order?
Create View AverageNumberOfProductReceived AS
Select Top 5 POD.PurchaseOrderID,AVG(POD.ReceivedQty) AS AverageNumberOfProductReceived
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductReceived Desc

Select * From AverageNumberOfProductReceived
--18
--18. What is the average number of products rejected per purchase order?
Create View AverageNumberOfProductRejected AS
Select TOP 5 POD.PurchaseOrderID,AVG(POD.RejectedQty) AS AverageNumberOfProductRejected
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductRejected Desc

Select * From AverageNumberOfProductRejected
--19
--19. What is the average number of products stocked per purchase order?
Create View AverageNumberOfProductStocked AS
Select Top 5 POD.PurchaseOrderID,AVG(POD.StockedQty) AS AverageNumberOfProductStocked
From [Purchasing].[PurchaseOrderDetail] POD
Group by POD.PurchaseOrderID
Order by AverageNumberOfProductStocked Desc

Select * From AverageNumberOfProductStocked
--20
--20. What is the average lead time for each product?
Create View AverageLeadTime AS
Select Top 5 PV.ProductID,AVG(PV.AverageLeadTime) AS AverageLeadTime
From [Purchasing].[ProductVendor] PV
Group by PV.ProductID
Order by PV.ProductID

Select * From AverageLeadTime
--21. What is the average number of employees in each department, and what is the average salary of those employees?
Create View AverageNumberOfEmployeeByDepartmentAndSalary AS 
Select HRD.DepartmentID,HRD.Name,Count(HRE.BusinessEntityID) AS AverageNumberOfEmployee,
AVG(HRP.Rate) AS AverageSalaryOfEmployee
From [HumanResources].[EmployeeDepartmentHistory] HRH
Left Join [HumanResources].[Employee] HRE
On HRH.BusinessEntityID = HRE.BusinessEntityID
Left Join [HumanResources].[EmployeePayHistory] HRP
On HRH.BusinessEntityID = HRP.BusinessEntityID
Left Join [HumanResources].[Department] HRD
On HRH.DepartmentID = HRD.DepartmentID
Group by HRD.DepartmentID,HRD.Name;

Select * From AverageNumberOfEmployeeByDepartmentAndSalary
--22. What is the average number of purchase orders placed by each employee, and what is the average total due for those orders?
Create View AverageNumbersOfPurchaseOrders AS
Select top 5 POH.EmployeeID,Count(POH.PurchaseOrderID) AS AverageNumbersOfPurchaseOrders ,
Sum(POH.TotalDue) AS AverageTotalDueForOrders
From [Purchasing].[PurchaseOrderHeader] POH
Group by POH.EmployeeID
Order by AverageTotalDueForOrders Desc
Select * From AverageNumbersOfPurchaseOrders
--23. What is the average number of products ordered by each vendor, and what is the average unit price of those products?
Create View AverageNumberOfProductOrdered AS
Select Top 5 POH.VendorID,PV.Name,Count(POD.OrderQty) AS AverageNumberOfProductOrdered, 
AVG(POD.UnitPrice) AS AverageUnitPriceProduct
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[PurchaseOrderDetail] POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by POH.VendorID,PV.Name
Order by AverageNumberOfProductOrdered Desc

Select * From AverageNumberOfProductOrdered
--24. What is the average number of days between order date and ship date for each vendor?
Create View AverageNumberOfDays AS 
Select Top 5 PV.Name,AVG(DATEDIFF(DAY,POH.OrderDate,POH.ShipDate)) AS AverageNumberOfDays
From [Purchasing].[PurchaseOrderHeader] POH
Left Join [Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Group by PV.Name
Order by AverageNumberOfDays Desc

Select * From AverageNumberOfDays
--25. What is the average number of products received per purchase order for each vendor?
Create View NumberOfProductsReceived  AS
Select Top 6 PV.BusinessEntityID,PV.Name,Count(POD.ReceivedQty) AS NumberOfProductsReceived
From [Purchasing].[PurchaseOrderHeader] POH
Left Join[Purchasing].[Vendor] PV
On POH.VendorID = PV.BusinessEntityID
Left Join [Purchasing].[PurchaseOrderDetail] POD
On POH.PurchaseOrderID = POD.PurchaseOrderID
Group by PV.BusinessEntityID,PV.Name
Order by NumberOfProductsReceived Desc

Select * From  NumberOfProductsReceived