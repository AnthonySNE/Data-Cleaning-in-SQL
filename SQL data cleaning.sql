Select SaleDateConverted, convert(date, SaleDate)
From Sheet1;


--Update Sheet1
--set SaleDate = convert(date, SaleDate);

Alter Table sheet1
add SaleDateConverted Date;

Update Sheet1
Set SaleDateConverted = convert(date,saledate)

select *
From sheet1


--Property Address

Select *
from sheet1
--where PropertyAddress is null
order by ParcelID

Select a.[UniqueID ], a.ParcelID, a.PropertyAddress, b.[UniqueID ],b.ParcelID,b.PropertyAddress, isnull(a.propertyaddress, b.PropertyAddress) 
from sheet1 as a
join sheet1 as b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
--where a.PropertyAddress is null

update a
set PropertyAddress= isnull(a.propertyaddress, b.PropertyAddress) 
from sheet1 as a
join sheet1 as b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null



-- Address individual columns (Address, city, state)

Select PropertyAddress
From sheet1

Select
SUBSTRING(propertyaddress, 1, CHARINDEX( ',',PropertyAddress)-1) as Street_Address
,SUBSTRING(propertyaddress, CHARINDEX( ',',PropertyAddress)+1, len(PropertyAddress)) as State
from sheet1


Alter Table sheet1
add Street_Address nvarchar(300);
Update Sheet1
Set Street_address = SUBSTRING(propertyaddress, 1, CHARINDEX( ',',PropertyAddress)-1) 


Alter Table sheet1
add City nvarchar(300);
Update Sheet1
Set City = SUBSTRING(propertyaddress, CHARINDEX( ',',PropertyAddress)+1, len(PropertyAddress))


Select  
PARSENAME(Replace(OwnerAddress,',', '.') ,3) Street
,PARSENAME(Replace(OwnerAddress,',', '.') ,2) City
,PARSENAME(Replace(OwnerAddress,',', '.') ,1) State
From sheet1

Alter Table sheet1
add OwnerSplitAddress nvarchar(300);
Update Sheet1
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',', '.') ,3) 



Alter Table sheet1
add OwnerStateCity nvarchar(300);
Update Sheet1
Set OwnerStateCity = PARSENAME(Replace(OwnerAddress,',', '.') ,2) 


Alter Table sheet1
add OwnerSplitState nvarchar(300);
Update Sheet1
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',', '.') ,1) 



--Sold as Vacant

Select distinct(SoldAsVacant), count(SoldAsVacant)
From sheet1
group by SoldAsVacant
order by 2


Select SoldAsVacant, 
case when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'No'
	 else soldasvacant 
	 End
From sheet1

update sheet1
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'No'
	 else soldasvacant 
	 End

--removing duplicates
With RowNumCTE as(
Select *,
	ROW_NUMBER() over
	(partition by ParcelID,
				  SalePrice,
				  SaleDate,
				  LegalReference
				  order by ParcelID
				  ) as Row_Num
From sheet1)
--Order by ParcelID
Select *
From RowNumCTE
where Row_Num > 1
Order by PropertyAddress



Select *
from sheet1

alter table sheet1
drop column owneraddress, taxdistrict, propertyaddress

alter table sheet1
drop column saledate






