/*


Cleaning Data in SQL Queries


*/
select * from dbo.NashvilleHousing

----------------------------------------------------------
--Standardize Data Format

select SaleDate ,convert(Date,SaleDate)
from dbo.NashvilleHousing


Alter Table NashvilleHousing
Add SaleDateConverted Date;


Update NashvilleHousing
Set SaleDateConverted = convert(Date,SaleDate)


select SaleDateConverted ,convert(Date,SaleDate)
from dbo.NashvilleHousing


----------------------------------------------
--Populate Property Address Data

select * 
from dbo.NashvilleHousing
where PropertyAddress is null



select *
from dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID


select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from dbo.NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


update a
set propertyaddress =  ISNULL(a.PropertyAddress,b.PropertyAddress)
from dbo.NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


-------------------------------------------------------------------------------
--Breaking Out Address into Individual Columns (Address, City, State)

select propertyaddress
from NashvilleHousing



select 
substring(propertyaddress,1, charindex(',',propertyaddress) -1) as Address,
substring(propertyaddress,charindex(',',propertyaddress) + 1, LEN(propertyaddress)) as Address
from dbo.NashvilleHousing



Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);


Update NashvilleHousing
Set PropertySplitAddress = substring(propertyaddress,1, charindex(',',propertyaddress) -1)


Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);


Update NashvilleHousing
Set PropertySplitCity = substring(propertyaddress,charindex(',',propertyaddress) + 1, LEN(propertyaddress))



select * from nashvillehousing

select owneraddress
from NashvilleHousing


select
PARSENAME(Replace(owneraddress,',','.') ,3),
PARSENAME(Replace(OwnerAddress,',','.') ,2),
PARSENAME(Replace(owneraddress,',','.'),1)
from NashvilleHousing


Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);


Update NashvilleHousing
Set  OwnerSplitAddress = PARSENAME(Replace(owneraddress,',','.') ,3);


Alter Table NashvilleHousing
Add  OwnerSplitCity Nvarchar(255);


Update NashvilleHousing
Set  OwnerSplitCity = PARSENAME(Replace(owneraddress,',','.') ,2)


Alter Table NashvilleHousing
Add  OwnerSplitState Nvarchar(255);


Update NashvilleHousing
Set  OwnerSplitState = PARSENAME(Replace(owneraddress,',','.') ,1)



-----------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field
select * from NashvilleHousing


select distinct(SoldAsVacant), count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant


Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From dbo.NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END



------------------------------------------------------
--Remove Duplicates

select * from NashvilleHousing
 --And check for Duplicate by using ParcelId,PropertyAddress,SalePrice,SaleDate,LegalReference

With RowNumCTE as (
select *,
	ROW_NUMBER() over(
	Partition by ParcelId,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by UniqueId
				 ) row_num
from NashvilleHousing
--order by ParcelID
)
Delete
from RowNumCTE
where Row_num > 1
--order by PropertyAddress



-----------------------------------------------------------
----Delete Unused Columns-------


Select * 
from NashvilleHousing

Alter Table NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

Alter Table NashvilleHousing
Drop Column SaleDate


Select * 
from NashvilleHousing

- --------------------------------------------------------------------------------------------------------