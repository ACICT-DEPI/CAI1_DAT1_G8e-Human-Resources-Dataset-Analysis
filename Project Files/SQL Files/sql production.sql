-- Data exploration
select * from Production.Product;
select * from Production.ProductInventory;
select * from Production.ProductCategory;
select * from production.ScrapReason;

use AdventureWorks2022;
select top 20 * from Production.BillOfMaterials;
select count(*) from Production.BillOfMaterials;
select distinct UnitMeasureCode from Production.BillOfMaterials;

select count( distinct ProductAssemblyID) from Production.BillOfMaterials;

select * from Production.Document;
select count(distinct FolderFlag) from Production.Document

select * from Production.Location

select * from production.Product;
select * from Production.ProductCategory;
select * from Production.ProductCostHistory
select * from Production.ProductDescription;
select * from Production.ProductInventory;
select * from Production.ProductListPriceHistory;
select * from Production.ProductModel;
select * from Production.ProductModelProductDescriptionCulture;
select * from Production.ProductPhoto;
select * from Production.ProductReview

select * from Production.ProductSubcategory;
select * from Production.ScrapReason;
select * from Production.TransactionHistory;
select * from Production.TransactionHistoryArchive;
select * from Production.UnitMeasure;
select * from Production.WorkOrder;
select * from Production.WorkOrderRouting;


SELECT * from Production.Product;
select * from Production.ProductSubcategory;

-- data cleaning 

select count(name) from Production.Product
where name is null; -- No Nulls in Name column


select count(MakeFlag) from Production.Product
where MakeFlag is null; -- No nulls in makeflag column

select count(FinishedGoodsFlag) from Production.Product
where FinishedGoodsFlag is null -- No Nulls in finished goods flag

select count(SafetyStockLevel) from Production.Product
where SafetyStockLevel is null
-- it will take to much time so we will use python to do this job
select @@SERVERNAME;
select DB_NAME();



select column_name from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Product'

select distinct ProductCategoryID from Production.ProductCategory;

select TransactionID from Production.TransactionHistory;
select * from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'Production';

select * from Production.ProductListPriceHistory;

select * from Production.ProductProductPhoto;

select count(ProductPhotoID) from Production.ProductProductPhoto where [Primary] is null;
select * from Production.BillOfMaterials;

select distinct TransactionType from Production.TransactionHistory;
select * from Production.Product;

select count(name) from production.Product where FinishedGoodsFlag=1;
select count(name) from Production.Product;

select * from Production.ProductCategory;

-- creating view having items that are out of stock or about to


create view below_needed as 
with inventory_quantity as 
(select ProductID, 
SUM(Quantity) as Total_Quantity 
from Production.ProductInventory

group by ProductID)

select * from below_needed;

-- creating view to get the average sales per each category grouped by month of the year

create view CategoryPriceChange as 
SELECT 
    FORMAT(pc.StartDate, 'yyyy-MM') AS date,
	c.name,
	c.ProductCategoryID,
    AVG(pc.StandardCost) AS AverageCost
FROM 
    Production.ProductCostHistory pc
join Production.Product p
on p.ProductID = pc.ProductID
join Production.ProductSubcategory ps
on ps.ProductSubcategoryID = p.ProductSubcategoryID
join Production.ProductCategory c
on c.ProductCategoryID = ps.ProductCategoryID
GROUP BY 
    FORMAT(pc.StartDate, 'yyyy-MM'), c.Name, c.ProductCategoryID;


with cte as
(select l.Name, SUM(Quantity) as total_quantity
from Production.ProductInventory I
join Production.Location l
ON L.LocationID = I.LocationID
group by l.Name)
select AVG(total_quantity) from cte

